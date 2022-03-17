create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports clk_i]
create_generated_clock -name time_clk -divide_by 125000000 -source [get_ports clk_i] [get_pins clk_divider0/time_clk_reg/Q];
