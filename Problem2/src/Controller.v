/* Controller.v
 * Implement the controller of the traffic light
 */

`include "def.v"

module Controller (
    input                     clk_i,
    input                     time_i,
    input      [`SW_SZ-1:0]   sw_i, 
    input      [`BTN_SZ-1:0]  btn_i, 
    output reg [`LED_SZ-1:0]  led4_o,
    output reg [`LED_SZ-1:0]  led5_o,
    output reg [`TIME_SZ-1:0] led_o
);

    // traffic light state definition
    parameter GR   = 3'd0,
              YR   = 3'd1,
              RR_1 = 3'd2,
              RG   = 3'd3,
              RY   = 3'd4,
              RR_2 = 3'd5;

    reg [2:0] current;             // current traffic light state    
    reg [`TIME_SZ-1:0] ctime;      // current traffic light count down time
    reg [`TIME_SZ-1:0] grlen = `DEFAULT_GR;
    reg [`TIME_SZ-1:0] yrlen = `DEFAULT_YR;
    reg [`TIME_SZ-1:0] rrlen = `DEFAULT_RR;
    
    always @(posedge time_i) begin
        if (ctime != 0) begin          // time != 0, count down
            ctime <= ctime - 1;
        end else begin                 // time == 0, change state
            // state transition
            if (current == RR_2) begin
                current <= GR;
            end else begin
                current <= current + 3'd1;
            end
            // change count down time for new state
            if (current == GR || current == RG) begin
                ctime <= grlen;
            end else if (current == YR || current == RY) begin
                ctime <= yrlen;
            end else begin
                ctime <= rrlen;
            end
        end
    end

    // switch/btn control
    reg [15:0] db_cnt;  // debounce counter
    always @(posedge clk_i) begin
        if (db_cnt == 16'hffff) begin
            if (btn_i[0] == 1'b1) begin            // reset 
                db_cnt <= 0;
                case (sw_i)
                    `ADJ_GR: grlen <= `DEFAULT_GR;
                    `ADJ_YR: yrlen <= `DEFAULT_YR;
                    `ADJ_RR: rrlen <= `DEFAULT_RR;
                    `NORMAL: begin end
                endcase
            end else if (btn_i[1] == 1'b1) begin  // add 1 sec
                db_cnt <= 0;
                case (sw_i)
                    `ADJ_GR: grlen <= (grlen == 15)? grlen : grlen + 1;
                    `ADJ_YR: yrlen <= (yrlen == 15)? yrlen : yrlen + 1;
                    `ADJ_RR: rrlen <= (rrlen == 15)? rrlen : rrlen + 1;
                    `NORMAL: begin end
                endcase
            end else if (btn_i[2] == 1'b1) begin  // minus 1 sec
                db_cnt <= 0;
                case (sw_i)
                    `ADJ_GR: grlen <= (grlen == 0)? grlen : grlen - 1;
                    `ADJ_YR: yrlen <= (yrlen == 0)? yrlen : yrlen - 1;
                    `ADJ_RR: rrlen <= (rrlen == 0)? rrlen : rrlen - 1;
                    `NORMAL: begin end
                endcase
            end
        end else begin
            db_cnt <= db_cnt + 1;
            case (sw_i)
                `ADJ_GR: led_o <= grlen;
                `ADJ_YR: led_o <= yrlen;
                `ADJ_RR: led_o <= rrlen;
                `NORMAL: led_o <= ctime;
            endcase
        end
    end
    
    // change LED color according to different states
    always @(*) begin
        if (sw_i == `NORMAL) begin
            case (current)
                GR:      led4_o = `GREEN;
                YR:      led4_o = `YELLOW;
                default: led4_o = `RED;
            endcase
            case (current)
                RG:      led5_o = `GREEN;
                RY:      led5_o = `YELLOW;
                default: led5_o = `RED;
            endcase
        end else if (sw_i == `ADJ_GR) begin
            led4_o = `GREEN;
            led5_o = `RED;
        end else if (sw_i == `ADJ_YR) begin
            led4_o = `YELLOW;
            led5_o = `YELLOW;
        end else begin
            led4_o = `WHITE;
            led5_o = `WHITE;
        end
    end

endmodule
