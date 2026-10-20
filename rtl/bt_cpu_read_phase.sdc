# The MC read-capture registers (READ_WORD and its alignment metadata) load
# only under CE_F (READ_LATCH). The byte-enable mask registers also load only
# under CE_F (launch, TMS34020_MC.sv BE_PIXMASK). Consecutive CE_F edges are
# >= 2 system clocks apart (bt_clock_enables: slots 1 and 3 of 5), so a CE_F
# target sees the capture registers at least two clocks old.
set bt_cpu_read_sources [get_registers {*|CPU|MC|READ_WORD[*] *|CPU|MC|READ_PREVIOUS[*] *|CPU|MC|READ_ALIGN[*] *|CPU|MC|READ_SIZE[*] *|CPU|MC|READ_OLD_SIZE[*] *|CPU|MC|READ_EXTENDED}]
set bt_cpu_read_f_targets [get_registers {*|CPU|MC|BE_PIXMASK[*]}]
if {[get_collection_size $bt_cpu_read_sources] == 0 || [get_collection_size $bt_cpu_read_f_targets] == 0} {
    error {CPU read-capture phase endpoints did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_cpu_read_sources -to $bt_cpu_read_f_targets
set_multicycle_path -hold -end 1 -from $bt_cpu_read_sources -to $bt_cpu_read_f_targets
puts "BT_CPU_READ_PHASE sources=[get_collection_size $bt_cpu_read_sources] f_targets=[get_collection_size $bt_cpu_read_f_targets] minimum_system_cycles=2"
