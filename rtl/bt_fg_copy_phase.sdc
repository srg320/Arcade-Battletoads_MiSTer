# Foreground copy gather: the RAM serial output is read into COPY_RAM_BYTE and
# consumed in the following collect state. fg_vram.sv (ifndef SYNTHESIS)
# asserts that the RAM word did not change on the edge before the capturing
# edge whenever a byte is consumed, so the capture may take two clocks.
set bt_fg_copy_sources [get_registers {*|FG0_VRAM|mem|banks*|*q_b[*] *|FG1_VRAM|mem|banks*|*q_b[*]}]
set bt_fg_copy_targets [get_registers {*|FG0_VRAM|COPY_RAM_BYTE[*] *|FG1_VRAM|COPY_RAM_BYTE[*]}]
if {[get_collection_size $bt_fg_copy_sources] == 0 ||
    [get_collection_size $bt_fg_copy_targets] == 0} {
    error {Foreground copy gather endpoints did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_fg_copy_sources -to $bt_fg_copy_targets
set_multicycle_path -hold -end 1 -from $bt_fg_copy_sources -to $bt_fg_copy_targets
puts "BT_FG_COPY sources=[get_collection_size $bt_fg_copy_sources] targets=[get_collection_size $bt_fg_copy_targets] minimum_clocks=2"
