`timescale 1ns/1ps
module abs_subtractor #(parameter DATA_WIDTH = 11) (
    input signed [DATA_WIDTH-1:0] a, // Input a
    input  signed [DATA_WIDTH-1:0] b, // Input b
    output signed [DATA_WIDTH-1:0] tout_sub // Output differenc
);

reg signed [DATA_WIDTH-1:0] tout_sub_temp ;
//assign tout_sub = a -b;

always@(*) begin
    tout_sub_temp = a-b;
    if(tout_sub_temp[10]== 1)
        tout_sub_temp = ~(tout_sub_temp)+1;
    else 
        tout_sub_temp = tout_sub_temp;
end

assign tout_sub = tout_sub_temp;
endmodule