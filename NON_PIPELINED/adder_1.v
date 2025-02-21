`timescale 1ns/1ps
module adder_1#(parameter DATA_WIDTH = 10) (
    input signed  [DATA_WIDTH-1:0] a, // Input a
    input signed [DATA_WIDTH-1:0] b, // Input b
    output signed [DATA_WIDTH-1:0] tout_adder // Output sum
);

assign tout_adder = a + b;

endmodule