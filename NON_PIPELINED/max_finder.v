`timescale 1ns/1ps
module max_finder #( parameter data_width = 11)(
    input signed  [data_width-1:0] num, // 10-bit input number
    output reg signed [data_width-1:0] tout_max_digit // 4-bit output maximum digit
);

//integer i;
//reg [data_width-1:0] digit;
//reg [data_width-1:0] temp;

reg signed [3:0] hundreds, tens, units; 
always @(*) begin
    // Extract hundreds, tens, and units place
    hundreds = (num / 100) % 10;
    tens = (num / 10) % 10;
    units = num % 10;
    
    if(hundreds > tens && hundreds > units)
        tout_max_digit = hundreds;
    else if(tens > hundreds && tens > units)
        tout_max_digit = tens;
    else
        tout_max_digit = units;
end

/*
always @(*) begin
    temp = num;
    tout_max_digit = 0;
    for (i = 0; i < 4; i = i + 1) begin
        digit = temp % 10;
        if (digit > tout_max_digit) begin
            tout_max_digit = digit;
        end
        temp = temp / 10;
    end
end
*/

endmodule