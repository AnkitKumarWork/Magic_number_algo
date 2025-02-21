module MAGIC_CONTROLLER (
    input clk,
    input rst,
    input start,
    input [3:0] count_out,
    output reg ld_n,
    output reg ld_acc,
    output reg ld_x,
    output reg count_enb,
    output reg reverse_en_1,
    output reg reverse_en_2,
    output reg count_reset,
    output reg done
);

parameter IDLE = 4'b0000;
parameter LOAD_N = 4'b0001;
parameter REVERSE_1 = 4'b0010;
parameter COMPARE = 4'b0011;
parameter SUBTRACT = 4'b0100;
parameter LOAD_X = 4'b0101;
parameter REVERSE_2 = 4'b0110;
parameter MAX_DIGIT = 4'b0111;
parameter ADDER = 4'b1000;
parameter LOAD_ACC = 4'b1001;
parameter DONE = 4'b1010;

reg [3:0] ps, ns; // present state and next state

// State transition
always @(posedge clk or posedge rst) begin
    if (rst)
        ps <= IDLE;
    else
        ps <= ns;
end

// Next state logic
always @(*) begin
    case (ps)
        IDLE: begin
            if (start)
                ns = LOAD_N;
            else
                ns = IDLE;
        end
        LOAD_N: ns = REVERSE_1;
        REVERSE_1: ns = COMPARE;
        COMPARE: ns = SUBTRACT;
        SUBTRACT: ns = LOAD_X;
        LOAD_X: ns = REVERSE_2;
        REVERSE_2: ns = MAX_DIGIT;
        MAX_DIGIT: ns = ADDER;
        ADDER: ns = LOAD_ACC;
        LOAD_ACC: begin
            if (count_out == 4'b1001) // Check if count_out is 9
                ns = DONE;
            else
                ns = LOAD_N;
        end
        DONE: ns = IDLE;
        default: ns = IDLE;
    endcase
end

// Output logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        ld_n <= 0;
        ld_acc <= 0;
        ld_x <= 0;
        count_enb <= 0;
        reverse_en_1 <= 0;
        reverse_en_2 <= 0;
        count_reset <= 0;
        done <= 0;
    end else begin
        case (ps)
            IDLE: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            LOAD_N: begin
                ld_n <= 1;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            REVERSE_1: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 1;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            COMPARE: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            SUBTRACT: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            LOAD_X: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 1;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            REVERSE_2: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 1;
                count_reset <= 0;
                done <= 0;
            end
            MAX_DIGIT: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            ADDER: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            LOAD_ACC: begin
                ld_n <= 0;
                ld_acc <= 1;
                ld_x <= 0;
                count_enb <= 1; // Enable count
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 0;
                done <= 0;
            end
            DONE: begin
                ld_n <= 0;
                ld_acc <= 0;
                ld_x <= 0;
                count_enb <= 0;
                reverse_en_1 <= 0;
                reverse_en_2 <= 0;
                count_reset <= 1;
                done <= 1;
            end
        endcase
    end
end

endmodule