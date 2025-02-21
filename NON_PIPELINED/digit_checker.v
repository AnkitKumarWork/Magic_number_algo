`timescale 1ns/1ps
module digit_checker #( parameter data_width = 11)(
    input signed  [data_width-1:0] num, // 10-bit input number
    output invalid // 4-bit output maximum digit
);

//integer i;
//reg [data_width-1:0] digit;
//reg [data_width-1:0] temp;
reg temp_invalid;
reg signed [3:0] hundreds, tens, units; 
always @(*) begin
    // Extract hundreds, tens, and units place
    hundreds = (num / 100) % 10;
    tens = (num / 10) % 10;
    units = num % 10;
    
    if(hundreds == tens || hundreds == units)
        temp_invalid= 1;
    else if(tens == hundreds || tens == units)
       temp_invalid= 1;
    else temp_invalid= 0;
        
end
assign invalid = temp_invalid;
endmodule