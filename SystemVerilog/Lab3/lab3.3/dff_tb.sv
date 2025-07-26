`timescale 1ps/1ps
module dff_tb;
    logic d, clk, clear, preset;
    logic q;

    // Instantiate the D flip-flop
    dff DFF (
        .d(d),
        .clk(clk),
        .clear(clear),
        .preset(preset),
        .q(q)
    );
    // Clock generation
    initial begin
        $dumpfile("dff_tb.vcd");
        $dumpvars(0, DFF); // Enable waveform dumping
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        $monitor("Time: %0t, d: %b, q: %b", $time, d, q);
        // Initialize inputs
        d = 0; clear = 1; preset = 0;
        
        // Wait for a clock cycle
        #10;
        
        // Clear the flip-flop
        clear = 0; preset = 1; 
        #10;
        clear = 1; preset = 1; // Deactivate preset
        // Set the flip-flop with a value
        d = 1; 
        #10;
        #50;

        // Change input and check output again
        d = 0; 
        #10;
        // Finish simulation
        $finish;
    end
endmodule