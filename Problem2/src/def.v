/* def.v
 * Define some neccessary values in this project
 */

/* position that controls color of LED */
`define B_POS 2
`define G_POS 1
`define R_POS 0

/* used colors */
`define WHITE 2'd0
`define RED 2'd1
`define GREEN 2'd2
`define YELLOW 2'd3

/* controller size define */
`define SW_SZ 2
`define BTN_SZ 3
`define LED_SZ 2    // len for RGB LED
`define TIME_SZ 4   // len for time

`define DEFAULT_GR 4'd5
`define DEFAULT_YR 4'd1
`define DEFAULT_RR 4'd1

/* define adjusting modes */
`define NORMAL 2'b00
`define ADJ_GR 2'b01
`define ADJ_YR 2'b10
`define ADJ_RR 2'b11

