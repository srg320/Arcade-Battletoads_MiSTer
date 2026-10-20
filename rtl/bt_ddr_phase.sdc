# CPU address changes only in CE_F. Ordinary reads follow in CE_R, and
# foreground-copy reads use the address captured by two memory stages.
# Write metadata is accepted after write_prepend under the CE_R window.
# Native simulation checks actual source ages at every read/write capture;
# this qualification also includes F-phase write-strobe clears.
# Keep physical register retiming off so these are the actual capture nodes.
set bt_ddr_address_sources [get_registers {*|CPU|MC|DBUS_A*}]
set bt_ddr_strobe_sources [get_registers {*|CPU|MC|DBUS_WE}]
set bt_ddr_code_sources [get_registers {*|CPU|MC|DBUS_CODE*}]
set bt_ddr_write_operand_sources [get_registers {*|CPU|MC|DOUT_BA_OLD* *|CPU|MC|DOUT_FS* *|CPU|MC|MC_EXT_WORD *|CPU|MC|DOUT_BUF*}]
set bt_ddr_read_targets [get_registers {*|ddram|read_addr* *|ddram|read_cache* *|ddram|read_bank_sel* *|ddram|read_return_sel* *|ddram|return_lanes*.read_return_sel_lane* *|ddram|read_busy *|ddram|busy_reg}]
set bt_ddr_write_targets [get_registers {*|ddram|write_addr* *|ddram|write_data* *|ddram|write_be* *|ddram|write_cache* *|ddram|write_tag_hit*}]
if {[get_collection_size $bt_ddr_address_sources] == 0 ||
    [get_collection_size $bt_ddr_strobe_sources] == 0 ||
    [get_collection_size $bt_ddr_read_targets] == 0 ||
    [get_collection_size $bt_ddr_write_targets] == 0} {
    error {Battletoads DDR transaction capture endpoints did not resolve}
}
# Both control-bank and physical output selectors retain their existing metadata budget.
foreach kind {read_bank_sel read_return_sel return_lanes*.read_return_sel_lane} {
    set nodes [get_registers "*|ddram|$kind*"]
    if {[get_collection_size $nodes] == 0} {
        error "DDR read metadata selector did not resolve: $kind"
    }
    puts "BT_DDR_READ_METADATA $kind=[get_collection_size $nodes] minimum_memory_cycles=2"
}
set_multicycle_path -setup -end 2 -from $bt_ddr_address_sources -to $bt_ddr_read_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_address_sources -to $bt_ddr_read_targets
set_multicycle_path -setup -end 2 -from $bt_ddr_address_sources -to $bt_ddr_write_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_address_sources -to $bt_ddr_write_targets
set_multicycle_path -setup -end 2 -from $bt_ddr_strobe_sources -to $bt_ddr_write_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_strobe_sources -to $bt_ddr_write_targets
# These fields have separate phase/acceptance assertions in native_sim.sv.
# DATA_OLD is deliberately excluded: it can change one memory clock before
# a write capture, so the general metadata bundle does not qualify.
if {[get_collection_size $bt_ddr_code_sources] == 0 ||
    [get_collection_size $bt_ddr_write_operand_sources] == 0} {
    error {DDR qualified code/write-operand sources did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_ddr_code_sources -to $bt_ddr_read_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_code_sources -to $bt_ddr_read_targets
set_multicycle_path -setup -end 2 -from $bt_ddr_write_operand_sources -to $bt_ddr_write_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_write_operand_sources -to $bt_ddr_write_targets
# The code (LA[3:0]) is published with the address in CE_F and selects the DDR
# bank of a write exactly as the address does; native_sim.sv asserts its age
# at every write capture (write_prepend in the CE_R window).
set_multicycle_path -setup -end 2 -from $bt_ddr_code_sources -to $bt_ddr_write_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_code_sources -to $bt_ddr_write_targets
# The strobe edge detectors and the registers they set. The address and code
# qualify the strobes (region decode, LA[3]); they are published in CE_F and
# the strobes that reach the DDR controller rise in CE_R, two memory clocks
# later: DBUS_WE for writes, and the CE_R-only DBUS_RD_EXT (not DBUS_RD, which
# also rises in CE_F for internal PIX/CST and screen-refresh transfers) for
# reads. Those strobes keep their single-clock checks, and a strobe clears in
# CE_R state 1 before the next CE_F address change, so the detector input is
# already low when a late address decode could still be settling.
# native_sim.sv asserts the address/code age at every strobe edge.
set bt_ddr_edge_targets [get_registers {*|ddram|old_we *|ddram|old_rd *|ddram|write_prepend *|ddram|write_busy}]
if {[get_collection_size $bt_ddr_edge_targets] == 0} {
    error {DDR strobe edge-detector registers did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_ddr_address_sources -to $bt_ddr_edge_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_address_sources -to $bt_ddr_edge_targets
set_multicycle_path -setup -end 2 -from $bt_ddr_code_sources -to $bt_ddr_edge_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_code_sources -to $bt_ddr_edge_targets
puts "BT_DDR_EDGE targets=[get_collection_size $bt_ddr_edge_targets] minimum_memory_cycles=2"
puts "BT_DDR_PHASE address_sources=[get_collection_size $bt_ddr_address_sources] strobe_sources=[get_collection_size $bt_ddr_strobe_sources] read_targets=[get_collection_size $bt_ddr_read_targets] write_targets=[get_collection_size $bt_ddr_write_targets] minimum_memory_cycles=2"

# Ready is observed in one F phase; the data word/cache write is captured in
# the following F phase. The real board harness checks data age at every valid
# capture (8.4 million captures in the qualification run). Only the named DDR cache -> these
# explicit data inputs receive two memory cycles; ready stays timed.
# Restrict this unchanged later-F budget to the DDR return cache and the
# physical combined bank/word selector. Earlier held-word FFs are excluded.
# Prefix patterns include routed ~DUPLICATE replicas of these same registers.
# Other MEM-clock paths into the CPU retain their ordinary timing checks.
set bt_ddr_return_sources [get_registers {*|ddram|*fill_data* *|ddram|*patch_data* *|ddram|*patch_valid* *|ddram|read_return_sel* *|ddram|return_lanes*.read_return_sel_lane*}]
foreach kind {fill_data patch_data patch_valid read_return_sel} {
    set nodes [get_registers "*|ddram|*$kind*"]
    if {[get_collection_size $nodes] == 0} {
        error "DDR return source group did not resolve: $kind"
    }
    puts "BT_DDR_RETURN_SOURCE $kind=[get_collection_size $nodes]"
}
# MC_DDR_WORD / CACHE_DDR_WORD sample the DDR return word at most two memory
# ticks before it is consumed (CE_F READ_LATCH / cache write). native_sim.sv
# asserts the word has been stable for >=4 memory ticks at every consumption
# (measured minimum 5 over 5.2M reads), so the capture edge sees >=2 stable ticks.
set bt_cpu_return_words [get_registers {*|CPU|MC|READ_WORD* *|CPU|MC|DATA_OLD* *|CPU|MC_DDR_WORD* *|CPU|CACHE|CACHE_DDR_WORD*}]
foreach kind {MC_DDR_WORD CACHE_DDR_WORD} {
    if {[get_collection_size [get_registers "*|CPU|*$kind*"]] == 0} { error "CPU DDR return capture register did not resolve: $kind" }
}
set bt_cpu_cache_inputs [get_registers {*|CPU|CACHE|CACHE_RAM|*DATAINREGOUT*}]
if {[get_collection_size $bt_ddr_return_sources] == 0 ||
    [get_collection_size $bt_cpu_return_words] == 0 ||
    [get_collection_size $bt_cpu_cache_inputs] == 0} {
    error {Qualified CPU memory-return capture endpoints did not resolve}
}
foreach target [list $bt_cpu_return_words $bt_cpu_cache_inputs] {
    set_multicycle_path -setup -start 2 -from $bt_ddr_return_sources -to $target
    set_multicycle_path -hold -start 1 -from $bt_ddr_return_sources -to $target
}
# DDR tag keys (read_addr) change only on a read miss start, a cache fill or a
# write-commit invalidate. native_sim.sv asserts that the youngest tag key is
# >=2 memory ticks old at every read start and write start (measured minimum 3
# and 4), so tag-key -> hit/miss/busy paths get two memory clocks. The REQUEST
# address side keeps single-cycle timing (foreground hole address and strobe
# change on the same edge by design).
# The address-independent tag predecode registers in bt_ddr_tag_compare (tag_class,
# tag0_rom_prefix, tag0_zero) are loaded one memory clock behind the tag key and
# are timed single-cycle in both directions (tag -> flag, flag -> hit_part): the
# two-tick key age asserted above covers exactly that split of the two-clock path.
set bt_ddr_tag_sources [get_registers {*|ddram|read_addr*}]
set bt_ddr_tag_targets [get_registers {*|ddram|read_busy *|ddram|busy_reg *|ddram|write_tag_hit* *|ddram|read_return_sel* *|ddram|return_lanes*.read_return_sel_lane* *|ddram|read_bank_sel* *|ddram|read_word_sel*}]
if {[get_collection_size $bt_ddr_tag_sources] == 0 || [get_collection_size $bt_ddr_tag_targets] == 0} {
    error {DDR tag-key endpoints did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_ddr_tag_sources -to $bt_ddr_tag_targets
set_multicycle_path -hold -end 1 -from $bt_ddr_tag_sources -to $bt_ddr_tag_targets
puts "BT_DDR_TAG sources=[get_collection_size $bt_ddr_tag_sources] targets=[get_collection_size $bt_ddr_tag_targets] minimum_memory_cycles=2"
puts "BT_DDR_RETURN sources=[get_collection_size $bt_ddr_return_sources] words=[get_collection_size $bt_cpu_return_words] cache_inputs=[get_collection_size $bt_cpu_cache_inputs] minimum_memory_cycles=2"

# FG/BG RAM, control and other memory-clock launches are not covered by a
# clock-wide exception. They retain ordinary timing unless separately proven.
# DATA_OLD is a return destination above; its CPU-to-DDR launch remains excluded
# from the write-metadata source collection because its available age differs.
