`timescale 1ns/1ps
module reg_acc #(parameter data_width = 10, out_width=8)(
    input clk, 
    input rst,
    input signed  [data_width-1:0]in_acc,
    input ld_acc,
    output signed [data_width-1:0] tout_acc
);
reg signed  [data_width-1:0] temp_acc;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_acc <= 0;
    else 
        if(ld_acc)
        temp_acc <= in_acc;
    
end
assign tout_acc = temp_acc;
endmodule