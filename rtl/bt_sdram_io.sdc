# MT48LC16M16A2 -75/-7E, CL=2 at 80 MHz: tAC <= 6 ns,
# command/address/data setup 1.5 ns and hold 0.8 ns; tOHn >= 1.8 ns.
# Micron Rev D, Table 12:
# https://www.micron-electronic.com/pdf-86/mt48lc16m16a2p-6a-aat-g-tr.pdf
# Budget 2 ns clock/return-data flight and 0.5 ns output clock/data skew.
# READ follows ACTIVE by 2 cycles. sampled_data captures the first/only word
# in the following cycle's receive phase, before the six-cycle busy boundary.
# Hold checks the first following edge: the one-word burst may then end.
# Use the minimum no-load data hold (1.8 ns), with zero minimum board flight.
set bt_sdram_master {}
foreach_in_collection bt_clock [get_clocks *] {
    set bt_clock_name [get_clock_info -name $bt_clock]
    if {[string first {emu|pll|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} $bt_clock_name] == 0} {
        set bt_sdram_master $bt_clock_name
    }
}
set bt_sdram_source [get_pins -compatibility_mode $bt_sdram_master]
if {[get_collection_size $bt_sdram_source] != 1} {error {SDRAM master clock must resolve once}}
create_generated_clock -name bt_sdram_clk -source $bt_sdram_source \
    -master_clock $bt_sdram_master -divide_by 1 -invert [get_ports SDRAM_CLK]
set bt_sdram_outputs [get_ports {SDRAM_A[*] SDRAM_BA[*] SDRAM_DQ[*] SDRAM_DQML SDRAM_DQMH SDRAM_nCS SDRAM_nRAS SDRAM_nCAS SDRAM_nWE SDRAM_CKE}]
set_output_delay -clock bt_sdram_clk -max 2.0 $bt_sdram_outputs
set_output_delay -clock bt_sdram_clk -min -1.3 $bt_sdram_outputs
set_input_delay -clock bt_sdram_clk -max 8.0 [get_ports {SDRAM_DQ[*]}]
set_input_delay -clock bt_sdram_clk -min 1.8 [get_ports {SDRAM_DQ[*]}]
set bt_sdram_capture [get_registers {*|sdram|sampled_data[*]}]
if {[get_collection_size $bt_sdram_capture] != 16} {error {SDRAM receive endpoints must resolve 16 times}}
set_multicycle_path -setup -start 2 -from [get_ports {SDRAM_DQ[*]}] -to $bt_sdram_capture
set_multicycle_path -hold -start 0 -from [get_ports {SDRAM_DQ[*]}] -to $bt_sdram_capture
# sample occurs in state 5; the sys bridge captures only at completion in
# state 6. The intervening sys edge has its bridge enable low. This exception
# is only that enabled transfer, not the sample-clock domain as a whole.
set bt_sdram_bridge [get_registers {*|sdram|last_data[*]}]
if {[get_collection_size $bt_sdram_bridge] != 16} {error {SDRAM bridge endpoints must resolve 16 times}}
set_multicycle_path -setup -end 2 -from $bt_sdram_capture -to $bt_sdram_bridge
set_multicycle_path -hold -end 1 -from $bt_sdram_capture -to $bt_sdram_bridge
derive_clock_uncertainty
