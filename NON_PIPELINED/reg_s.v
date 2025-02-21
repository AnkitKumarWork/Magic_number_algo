`timescale 1ns/1ps
module reg_s #(parameter data_width = 10)(
    input clk, 
    input rst,
    input signed [data_width-1:0]in_s,
    input ld_s,
    output signed [data_width-1:0] tout_s
);
reg signed [data_width-1:0] temp_s;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_s <= 0;
    else 
        if(ld_s)
        temp_s <= in_s;
    
end
assign tout_s = temp_s;
endmodule