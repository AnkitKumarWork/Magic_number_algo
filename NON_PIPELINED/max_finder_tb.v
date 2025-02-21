`timescale 1ns/1ps

module max_finder_tb;

    // Parameters
    parameter DATA_WIDTH = 10;

    // Inputs
    reg [DATA_WIDTH-1:0] num;

    // Outputs
    wire [3:0] tout_max_digit;

    // Instantiate the Unit Under Test (UUT)
    max_finder #(DATA_WIDTH) uut (
        .num(num),
        .tout_max_digit(tout_max_digit)
    );

    initial begin
        // Initialize Inputs
        num = 10'b0000000000; // 0
        #10;
        num = 10'b0000001001; // 9
        #10;
        num = 10'b0000010101; // 21
        #10;
        num = 10'b0000110011; // 51
        #10;
        num = 10'b0010101010; // 170
        #10;
        num = 10'b1111111111; // 1023
        #10;

        // Add more test cases as needed
        $stop;
    end

    initial begin
        $monitor("At time %t, num = %d, tout_max_digit = %d", $time, num, tout_max_digit);
    end

endmodule