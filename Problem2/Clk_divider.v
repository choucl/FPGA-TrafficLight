module Clk_divider(
    input      clk_i,
    input      rst_i,
    output reg clk_o
);

    reg [25:0] cnt;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            cnt   <= 26'd0;
            clk_o <= 1'b0;
        end else begin
            if (cnt == 26'd67108863) begin
                cnt <= 26'd0;
            end else begin
                cnt <= cnt + 26'd1;
            end
            
            if (cnt < 26'd33554431) begin
                clk_o <= 1'b0;
            end else begin
                clk_o <= 1'b1;
            end
        end 
    end

endmodule
