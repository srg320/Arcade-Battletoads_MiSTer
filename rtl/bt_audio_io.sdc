# ADV7513 Rev B: I2S/LRCLK setup and hold 2 ns; add 0.25 ns skew.
# https://www.analog.com/media/en/technical-documentation/data-sheets/ADV7513.pdf
# The shipping fractional CE generator has spacing >=4 audio clocks for
# both sample rates, including switching. Data changes at CE with msclk=1.
# SCLK follows msclk one clock later: rising edge >=5 clocks after data,
# next data >=3 clocks after the rising edge. qualify_io_phase.py checks
# these bounds on shipping RTL with rate switching and resets.
set bt_audio_master {}
foreach_in_collection bt_clock [get_clocks *] {
    set bt_clock_name [get_clock_info -name $bt_clock]
    if {[string first {pll_audio|} $bt_clock_name] == 0 &&
        [string first {divclk} $bt_clock_name] >= 0} {
        set bt_audio_master $bt_clock_name
    }
}
set bt_audio_source [get_pins -compatibility_mode $bt_audio_master]
if {[get_collection_size $bt_audio_source] != 1} {error {Audio master clock must resolve once}}
set bt_i2s_divider [get_registers {audio_out|i2s|sclk}]
set bt_i2s_clk [get_pins -compatibility_mode {audio_out|i2s|sclk|clk}]
set bt_i2s_q [get_pins -compatibility_mode {audio_out|i2s|sclk|q}]
if {[get_collection_size $bt_i2s_divider] != 1 ||
    [get_collection_size $bt_i2s_clk] != 1 ||
    [get_collection_size $bt_i2s_q] != 1} {error {I2S divider endpoints must resolve once}}
# Declare the divider first, then propagate its clock through the real output
# route. Defining only the port clock drops the divider's source-clock latency.
create_generated_clock -name bt_audio_sclk_internal -source $bt_i2s_clk \
    -master_clock $bt_audio_master -divide_by 8 $bt_i2s_divider
create_generated_clock -name bt_hdmi_i2s -source $bt_i2s_q \
    -master_clock bt_audio_sclk_internal -divide_by 1 [get_ports HDMI_SCLK]
create_generated_clock -name bt_hdmi_mclk -source $bt_audio_source \
    -master_clock $bt_audio_master -divide_by 1 [get_ports HDMI_MCLK]
set bt_audio_data [get_ports {HDMI_I2S HDMI_LRCLK}]
set_output_delay -clock bt_hdmi_i2s -max 2.25 $bt_audio_data
set_output_delay -clock bt_hdmi_i2s -min -2.25 $bt_audio_data
set bt_audio_registers [get_registers {audio_out|i2s|sdata audio_out|i2s|lrclk}]
if {[get_collection_size $bt_audio_registers] != 2} {error {Audio phase endpoints must resolve twice}}
set_multicycle_path -setup -start 5 -from $bt_audio_registers -to $bt_audio_data
set_multicycle_path -hold -start 7 -from $bt_audio_registers -to $bt_audio_data
derive_clock_uncertainty
