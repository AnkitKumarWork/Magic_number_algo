`timescale 1ns/1ps
module adder_2#(parameter data_width  = 10, out_width=8) (
    input signed [data_width-1:0] a, // Input a
    input signed [data_width-1:0] b, // Input b
    output signed [data_width-1:0] tout_adder // Output sum
);

assign tout_adder = a + b;

endmodule