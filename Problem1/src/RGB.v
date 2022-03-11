/*  
 * RGB.v
 * Problem1 implementation
 */

`include "def.v"

module RGB(
    input [1:0]      sw_i,
    output reg [2:0] rgb_o
);

    always @(*) begin
        case (sw_i)
            `WHITE: begin
                rgb_o[`B_POS] = 1'b1;
                rgb_o[`G_POS] = 1'b1;
                rgb_o[`R_POS] = 1'b1;
            end
            `RED: begin
                rgb_o[`B_POS] = 1'b0;
                rgb_o[`G_POS] = 1'b0;
                rgb_o[`R_POS] = 1'b1;
            end
            `GREEN: begin
                rgb_o[`B_POS] = 1'b0;
                rgb_o[`G_POS] = 1'b1;
                rgb_o[`R_POS] = 1'b0;
            end
            `YELLOW: begin
                rgb_o[`B_POS] = 1'b0;
                rgb_o[`G_POS] = 1'b1;
                rgb_o[`R_POS] = 1'b1;
            end
            default: rgb_o = 3'b000;
        endcase
    end

endmodule
