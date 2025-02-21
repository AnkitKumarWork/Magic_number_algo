`timescale 1ns/1ps
module Reverse_module_2 #(parameter data_width = 11)(
    input signed [data_width-1:0] x,
    input reverse_en_2,
    output signed [data_width-1:0] tout_rev_x
);

reg signed [data_width-1:0] temp_x;
reg signed [data_width-1:0] abs_x;
reg [3:0] hundreds, tens, units;  // 4-bit registers to store digits
reg signed [data_width-1:0] reversed_x;

always @(*) 
begin
        if (reverse_en_2)
        begin
            // Take absolute value
            if (x < 0)
                abs_x = -x;
            else
                abs_x = x;

            // Extract only three digits
            hundreds = (abs_x / 100) % 10;
            tens = (abs_x / 10) % 10;
            units = abs_x % 10;

            // Reconstruct reversed number
            reversed_x = (units * 100) + (tens * 10) + hundreds;

            // Restore sign if the original number was negative
            if (x < 0)
                temp_x = -reversed_x;
            else
                temp_x = reversed_x;
        end
        else
            temp_x = x;
    end

assign tout_rev_x = temp_x;

endmodule
