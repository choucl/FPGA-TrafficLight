/*  
 * RGB.v
 * Problem1 implementation
 */

module RGB(
    input [1:0]      sw_i,
    output reg [2:0] rgb_o
);

    // Output color of RGB
    parameter WHITE  = 3'b111,
              RED    = 3'b001,
              GREEN  = 3'b010,
              YELLOW = 3'b011;

    always @(*) begin
        case (sw_i)
            2'b00: rgb_o = WHITE;
            2'b01: rgb_o = RED;
            2'b10: rgb_o = GREEN;
            2'b11: rgb_o = YELLOW;
            default: rgb_o = 3'b000;
        endcase
    end

endmodule
