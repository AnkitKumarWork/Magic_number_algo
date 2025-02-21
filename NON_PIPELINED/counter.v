`timescale 1ns/1ps
module counter(
    input clk,
    input rst,
    input count_enb,
    output [3:0] count_out,
    input count_reset
);

reg [3:0]count_value;

always@(posedge clk or posedge rst)
begin
  if(rst )
        count_value <= 0;
    else
        if(count_enb)
            count_value <= count_value + 1;
        else if(count_reset)
            count_value <=0;
end
assign count_out = count_value;
endmodule