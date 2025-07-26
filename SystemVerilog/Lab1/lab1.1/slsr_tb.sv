`timescale 1ns/1ps

module slsr_tb;
    reg sl, sr, din, clk, reset;
    wire [7:0] Q;

    slsr uut (
        .sl(sl),
        .sr(sr),
        .din(din),
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    initial begin
        // Initialize inputs
        sl = 0;
        sr = 0;
        din = 0;
        clk = 0;
        reset = 0;
		$monitor("Time: %0t, Q: %b", $time, Q);

        // Apply reset
        reset = 1;
        #10;
        reset = 0;

        // Test shift left
        sl = 1;
        din = 1;
        #10;

        // Test shift right
        sl = 0;
        sr = 1;
        #10;

        // Finish simulation
        $finish;
    end

    // Clock generation
    initial begin
        forever begin
            clk = ~clk;
            #5;
        end
    end

endmodule