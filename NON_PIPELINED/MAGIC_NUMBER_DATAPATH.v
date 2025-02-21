module MAGIC_DATAPATH #( parameter data_width = 10, out_width = 8)(
    input clk,
    input rst,
    input signed [data_width-1:0] n,
    input ld_n,
    input ld_acc,
    input ld_x,
    input count_enb,
    input reverse_en_1, 
    input reverse_en_2,
    input count_reset,
    output signed [data_width-1:0] F,
    output signed reg [out_width-1:0] S,  // Ensure S is properly registered
    output [3:0] count_out
);

wire [data_width-1:0] tout_n;
wire [data_width-1:0] tout_rev_n;
wire [data_width-1:0] out_a;
wire [data_width-1:0] out_b;
wire [data_width-1:0] tout_sub;
wire [data_width-1:0] tout_x;
wire [data_width-1:0] tout_rev_x;
wire [3:0] tout_max_digit;
wire [out_width-1:0] tout_adder;
wire [out_width-1:0] tout_acc;

reg_n reg_n1(
    .clk(clk),
    .rst(rst),
    .n(n),
    .ld_n(ld_n),
    .tout_n(tout_n)
);

Reverse_module_1 rev1(
    .clk(clk),
    .rst(rst),
    .n(tout_n),
    .reverse_en_1(reverse_en_1),
    .tout_rev_n(tout_rev_n)
);

comparator  comp1(
    .a(tout_n),
    .b(tout_rev_n),
    .out_a(out_a),
    .out_b(out_b)
);

subtractor sub1(
    .a(out_a),
    .b(out_b),
    .tout_sub(tout_sub)
);

reg_x  reg_x1(
    .clk(clk),
    .rst(rst),
    .x(tout_sub),
    .ld_x(ld_x),
    .tout_x(tout_x)
);

Reverse_module_2  rev2(
    .clk(clk),
    .rst(rst),
    .x(tout_x),
    .reverse_en_2(reverse_en_2),
    .tout_rev_x(tout_rev_x)
);

adder_1 add1(
    .a(tout_x),
    .b(tout_rev_x),
    .tout_adder(F)  // Ensure this output is correctly used
);

max_finder  max1(
    .num(tout_rev_x),
    .tout_max_digit(tout_max_digit)
);

adder_2  add2(
    .a(tout_max_digit),
    .b(tout_acc),
    .tout_adder(tout_adder)
);

reg_acc  reg_acc1(
    .clk(clk),
    .rst(rst),
    .in_acc(tout_adder),
    .ld_acc(ld_acc),
    .tout_acc(tout_acc)
);

// Ensure S gets updated properly
always @(posedge clk or posedge rst) begin
    if (rst)
        S <= 0;
    else if (ld_acc)
        S <= tout_acc;
end

counter count1(
    .clk(clk),
    .rst(rst),
    .count_enb(count_enb),
    .count_reset(count_reset),
    .count_out(count_out)
);

endmodule
