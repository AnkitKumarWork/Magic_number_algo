`timescale 1ns/1ps
module Reverse_module_1 #(parameter data_width = 11)(
    input clk,
    input rst,
    input signed [data_width-1:0] n,
    input reverse_en_1,
    //input add_en,
    output signed  [data_width-1:0] tout_rev_n
);
reg [data_width-1:0] temp_n;


function [data_width-1:0] reverse_digits;
    input [data_width-1:0] num;
    reg [3:0] hundreds, tens, units;
    begin
        // Extract hundreds, tens, and units place
        hundreds = (num / 100) % 10;
        tens = (num / 10) % 10;
        units = num % 10;
        
        // Reverse the digits
        reverse_digits = (units * 100) + (tens * 10) + hundreds;
    end
endfunction

always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_n <= 0;
    else 
        if(reverse_en_1)
            temp_n <= reverse_digits(n);
        else
            temp_n <= n;
end

assign tout_rev_n = temp_n;

endmodule