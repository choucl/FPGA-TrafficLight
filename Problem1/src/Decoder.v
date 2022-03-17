/*  
 * Decoder.v
 * Problem1 implementation
 */

`include "def.v"

module Decoder(
    input [1:0]      sw_i,
    output reg [2:0] rgb_o
);

    always @(*) begin
        case (sw_i)
            `WHITE:  rgb_o = `WHITE_CODE;
            `RED:    rgb_o = `RED_CODE;
            `GREEN:  rgb_o = `GREEN_CODE;
            `YELLOW: rgb_o = `YELLOW_CODE;
            default: rgb_o = 3'b000;
        endcase
    end

endmodule
