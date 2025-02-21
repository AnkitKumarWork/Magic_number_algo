`timescale 1ns/1ps

module Reverse_module_1_tb;

    // Parameters
    parameter DATA_WIDTH = 10;

    // Inputs
    //reg clk;
    //reg rst;
    reg signed  [DATA_WIDTH-1:0] n;
    reg reverse_en_1;

    // Outputs
    wire signed [DATA_WIDTH-1:0] tout_rev_n;

    // Instantiate the Unit Under Test (UUT)
    Reverse_module_1 #(DATA_WIDTH) uut (
       // .clk(clk),
       // .rst(rst),
        .n(n),
        .reverse_en_1(reverse_en_1),
        .tout_rev_n(tout_rev_n)
    );

    // Clock generation
   // always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
       // clk = 0;
       // rst = 0;
        n = 0;
        reverse_en_1 = 0;

        // Apply reset
       // rst = 1;
        #10;
       // rst = 0;

        // Test case 1: Reverse disabled
        n = 10'b0000001001; // 9
        reverse_en_1 = 0;
        #10;

        // Test case 2: Reverse enabled
        reverse_en_1 = 1;
        #10;

        // Test case 3: Another number with reverse enabled
        n = 10'b0000010101; // 21
        #10;

        // Test case 4: Another number with reverse enabled
        n = 10'b0000110011; // 51
        #10;

        // Test case 5: Another number with reverse enabled
        n = 10'b0010101010; // 170
        #10;

        // Test case 6: Another number with reverse enabled
        n = 10'd123; // 123
        #10;

        // Add more test cases as needed
        $stop;
    end

    initial begin
        $monitor("At time %t, n = %d, reverse_en_1 = %b, tout_rev_n = %d", $time, n, reverse_en_1, tout_rev_n);
    end

endmodule