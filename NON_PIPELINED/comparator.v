`timescale 1ns/1ps
module comparator #(parameter data_width = 10)(
    input signed [data_width-1:0] a, // data_width-bit input a
    input signed [data_width-1:0] b, // data_width-bit input b
    output reg signed [data_width-1:0] out_a, // data_width-bit output out_a
    output reg  signed [data_width-1:0] out_b  // data_width-bit output out_b
);

always @(*) begin
    if (a > b) begin
        out_a = a;
        out_b = b;
    end else if (a < b) begin
        out_a = b;
        out_b = a;
    end else begin
        out_a = a;
        out_b = b;
    end
end

endmodule