`timescale 1ns/1ps
module reg_x #( parameter data_width = 10)(
    input clk, 
    input rst,
    input signed [data_width-1:0]x,
    input ld_x,
    output signed [data_width-1:0] tout_x
);
reg signed [data_width-1:0] temp_x;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_x <= 0;
    else 
        if(ld_x)
        temp_x<= x;
    
end
assign tout_x = temp_x;
endmodule