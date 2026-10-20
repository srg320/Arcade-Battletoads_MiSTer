# BSMT TMS320C1X uses alternating 6 MHz F/R enables on the 80 MHz clock.
# IC/IW update in F; architectural arithmetic/control registers update in R.
# Consecutive opposite phases are >=6 sys clocks apart; same R phases >=13.
# Qualify actual enable spacing and ownership in native_sim.sv. Use only a
# conservative two-clock allowance between these explicitly owned registers;
# external bus inputs, asynchronous RAM and free-running registers retain
# their single-clock requirements.
# ST is a packed struct: its members are netlist registers named ST.<field>.
set bt_dsp_r_registers [get_registers {*|BSMT|ACC* *|BSMT|AR[*]* *|BSMT|T[*]* *|BSMT|P[*]* *|BSMT|ST.* *|BSMT|PC[*]* *|BSMT|STATE[*]* *|BSMT|STACK[*]*}]
if {[get_collection_size [get_registers {*|BSMT|ST.*}]] == 0} {
    error {BSMT status-register members did not resolve}
}
set bt_dsp_f_registers [get_registers {*|BSMT|IC[*]* *|BSMT|IW[*]*}]
if {[get_collection_size $bt_dsp_r_registers] == 0 ||
    [get_collection_size $bt_dsp_f_registers] == 0} {
    error {BSMT phase-owned register endpoints did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_dsp_r_registers -to $bt_dsp_r_registers
set_multicycle_path -hold -end 1 -from $bt_dsp_r_registers -to $bt_dsp_r_registers
set_multicycle_path -setup -end 2 -from $bt_dsp_f_registers -to $bt_dsp_r_registers
set_multicycle_path -hold -end 1 -from $bt_dsp_f_registers -to $bt_dsp_r_registers
# The DSP data RAM (MLAB, unregistered read) is written only under
# DECI.RAMW & EN & CE_R: its stored data is an R-phase source like the R
# registers. Its read address comes from IC (F) and ST.DP/AR (R).
set bt_dsp_ram_stored [get_registers {*|BSMT|RAM|*MEMORYREGOUT*}]
# MEMORYREGOUT exists only in the fitted timing netlist (see bt_cpu_phase.sdc);
# the final audit requires ram_stored to be non-zero.
if {[get_collection_size $bt_dsp_ram_stored] != 0} {
    set_multicycle_path -setup -end 2 -from $bt_dsp_ram_stored -to $bt_dsp_r_registers
    set_multicycle_path -hold -end 1 -from $bt_dsp_ram_stored -to $bt_dsp_r_registers
}
puts "BT_DSP_PHASE r_registers=[get_collection_size $bt_dsp_r_registers] f_registers=[get_collection_size $bt_dsp_f_registers] ram_stored=[get_collection_size $bt_dsp_ram_stored] conservative_sys_cycles=2"

# Sound Z80: T80pa:Z80|T80:u0. Every register inside the T80 core (T80.vhd
# main/register/control processes, T80_Reg) updates only under ClkEn = CEN and
# not BusAck, or under the DIRSet save-state load that is tied off; BUSRQ_n
# and NMI_n are tied inactive so BusAck/NMI_s never change. T80pa drives CEN
# from CEN_p = SCE_R, the same 6 MHz R phase the BSMT uses: consecutive core
# enables are >= 13 system clocks apart (native_sim.sv qualifies that spacing).
# Conservative two-clock allowance between core registers only; T80pa's own
# pseudo-asynchronous bus registers, the sound-port handshake and every input
# from the system clock keep their single-clock requirements.
set bt_z80_core_registers [get_registers {*|Z80|u0|*}]
if {[get_collection_size $bt_z80_core_registers] == 0} {
    error {T80 core register endpoints did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_z80_core_registers -to $bt_z80_core_registers
set_multicycle_path -hold -end 1 -from $bt_z80_core_registers -to $bt_z80_core_registers
puts "BT_Z80_PHASE core_registers=[get_collection_size $bt_z80_core_registers] conservative_sys_cycles=2"
