`timescale 1ns/1ps
module Reverse_module_1 #(parameter data_width = 11)(
    input signed [data_width-1:0] n,
    input reverse_en_1,
    output reg signed [data_width-1:0] tout_rev_n
);

reg signed [data_width-1:0] abs_n;
reg [3:0] hundreds, tens, units;  
reg signed [data_width-1:0] reversed_n;

always @(*) 
begin
    if (reverse_en_1) 
    begin
        // Take absolute value
        abs_n = (n < 0) ? -n : n;

        // Extract only three digits
        hundreds = (abs_n / 100) % 10;
        tens = (abs_n / 10) % 10;
        units = abs_n % 10;

        // Reconstruct reversed number
        reversed_n = (units * 100) + (tens * 10) + hundreds;

        // Restore sign if the original number was negative
        tout_rev_n = (n < 0) ? -reversed_n : reversed_n;
    end 
    else 
    begin
        tout_rev_n = n;
    end
end

endmodule
