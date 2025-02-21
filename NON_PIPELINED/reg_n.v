`timescale 1ns/1ps
module reg_n #( parameter data_width = 10)(
    input clk, 
    input rst,
    input signed [data_width-1:0]n,
    input ld_n,
    output signed [data_width-1:0] tout_n
);
reg signed [data_width-1:0] temp_n;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_n <= 0;
    else 
        if(ld_n)
        temp_n <= n;
    
end
assign tout_n = temp_n;
endmodule