`timescale 1ps/1ps
module prbs_tb;
    reg clk, reset;
    wire random_out;

    // Instantiate the PRBS module
    prbs testprbs (
        .clk(clk),
        .reset(reset),
        .random_out(random_out)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;

        // Apply reset
        reset = 1;
        #10;
        reset = 0;

        // Display output at each clock edge
        repeat(20) begin
            #10; // Wait for clock edge
            $display("Time: %0t, rand: %b", $time, random_out);
        end

        // Finish simulation
        $finish;
    end

    // Clock generation
    initial begin
        forever begin
            clk = ~clk;
            #5; // Clock period of 10 time units
        end
    end
endmodule