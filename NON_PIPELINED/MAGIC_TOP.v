module MAGIC_TOP #(parameter data_width = 10, out_width = 8)(
    input clk,
    input rst,
    input start,
    input [data_width-1:0] n,
    output [data_width-1:0] F,
    output [out_width-1:0] S,
    output done
);

// Internal signals
wire ld_n, ld_acc, ld_x;
wire count_enb, reverse_en_1, reverse_en_2;
wire count_reset;
wire [3:0] count_out;

// Instantiate MAGIC_DATAPATH
MAGIC_DATAPATH #(data_width, out_width) datapath (
    .clk(clk),
    .rst(rst),
    .n(n),
    .ld_n(ld_n),
    .ld_acc(ld_acc),
    .ld_x(ld_x),
    .count_enb(count_enb),
    .reverse_en_1(reverse_en_1),
    .reverse_en_2(reverse_en_2),
    .count_reset(count_reset),
    .F(F),
    .S(S),
    .count_out(count_out)
);

// Instantiate MAGIC_CONTROLLER
MAGIC_CONTROLLER controller (
    .clk(clk),
    .rst(rst),
    .start(start),
    .count_out(count_out),
    .ld_n(ld_n),
    .ld_acc(ld_acc),
    .ld_x(ld_x),
    .count_enb(count_enb),
    .reverse_en_1(reverse_en_1),
    .reverse_en_2(reverse_en_2),
    .count_reset(count_reset),
    .done(done)
);

endmodule
