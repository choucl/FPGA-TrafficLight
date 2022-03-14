/* top.v
 * The top module of the traffic light
 */

`include "def.v"
`include "Clk_divider.v"
`include "Controller.v"

module top(
    input                 clk_i,
    input                 rst_i,
    input  [`SW_SZ-1:0]   sw_i, 
    input  [`BTN_SZ-1:0]  btn_i, 
    output [`LED_SZ-1:0]  led4_o,
    output [`LED_SZ-1:0]  led5_o,
    output [`TIME_SZ-1:0] led_o
);

wire time_clk;

Controller Controller0(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .time_i(time_clk),
    .sw_i(sw_i), 
    .btn_i(btn_i), 
    .led4_o(led4_o),
    .led5_o(led5_o),
    .led_o(led_o)
);

Clk_divider clk_divider0(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .clk_o(time_clk)
);

endmodule