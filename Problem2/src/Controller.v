/* Controller.v
 * Implement the controller of the traffic light
 */

`include "def.v"

module Controller (
    input                     clk_i,
    input                     rst_i,
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

    reg [2:0] cstate;              // current traffic light state    
    reg [`TIME_SZ-1:0] ctime;      // current traffic light count down time
    reg [`TIME_SZ-1:0] grlen = `DEFAULT_GR;
    reg [`TIME_SZ-1:0] yrlen = `DEFAULT_YR;
    reg [`TIME_SZ-1:0] rrlen = `DEFAULT_RR;
    
    always @(posedge time_i or posedge rst_i) begin
        if (rst_i == 1'b1) begin 
            cstate  <= GR;
            ctime   <= `DEFAULT_GR;
        end else begin
            if (ctime != 0) begin          // time != 0, count down
                ctime <= ctime - 1;
            end else begin                 // time == 0, change state
                // state transition
                if (cstate == RR_2) begin
                    cstate <= GR;
                end else begin
                    cstate <= cstate + 3'd1;
                end
                // change count down time for new state
                if (cstate == GR || cstate == RG) begin
                    ctime <= grlen;
                end else if (cstate == YR || cstate == RY) begin
                    ctime <= yrlen;
                end else begin
                    ctime <= rrlen;
                end
            end
        end
    end

    // switch/btn control
    reg [27:0] db_cnt;  // debounce counter
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i == 1'b1) begin
            db_cnt <= 28'h1ffffff;
            grlen  <= `DEFAULT_GR;
            yrlen  <= `DEFAULT_YR;
            rrlen  <= `DEFAULT_RR;
        end else begin
            if (db_cnt == 28'h1ffffff) begin
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
                        `ADJ_GR: grlen <= (grlen == 1)? grlen : grlen - 1;
                        `ADJ_YR: yrlen <= (yrlen == 1)? yrlen : yrlen - 1;
                        `ADJ_RR: rrlen <= (rrlen == 1)? rrlen : rrlen - 1;
                        `NORMAL: begin end
                    endcase
                end
            end else begin
                db_cnt <= db_cnt + 1;
            end
        end
        case (sw_i)
            `ADJ_GR: led_o <= grlen;
            `ADJ_YR: led_o <= yrlen;
            `ADJ_RR: led_o <= rrlen;
            `NORMAL: led_o <= ctime;
        endcase
    end
    
    // change LED color according to different states
    always @(*) begin
        if (sw_i == `NORMAL) begin
            case (cstate)
                GR:      led4_o = `GREEN_CODE;
                YR:      led4_o = `YELLOW_CODE;
                default: led4_o = `RED_CODE;
            endcase
            case (cstate)
                RG:      led5_o = `GREEN_CODE;
                RY:      led5_o = `YELLOW_CODE;
                default: led5_o = `RED_CODE;
            endcase
        end else if (sw_i == `ADJ_GR) begin
            led4_o = `GREEN_CODE;
            led5_o = `RED_CODE;
        end else if (sw_i == `ADJ_YR) begin
            led4_o = `YELLOW_CODE;
            led5_o = `YELLOW_CODE;
        end else begin
            led4_o = `WHITE_CODE;
            led5_o = `WHITE_CODE;
        end
    end

endmodule
