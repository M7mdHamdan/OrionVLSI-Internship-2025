`timescale 1ns/1ps
module MyMem_tb;
    reg clk, reset, sel, wr;
    reg [15:0] wdata;
    reg [3:0] addr;
    wire [15:0] rdata;
    // Instantiate the MyMem module
    MyMem uut (
        .wdata(wdata),
        .sel(sel),
        .wr(wr),
        .clk(clk),
        .reset(reset),
        .addr(addr),
        .rdata(rdata)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        sel = 0;
        wr = 0;
        wdata = 16'b0;
        addr = 4'b0;

        // Apply reset
        reset = 1;
        #10;
        reset = 0;

        // Write data to memory
        sel = 1; wr = 1; addr = 4'b0001; wdata = 16'hA5A5; // Write A5A5 to address 1
        #10;

        // Read data from memory
        sel = 1; wr = 0; addr = 4'b0001; // Read from address 1
        #10;
        $display("Time: %0t, rdata: %h", $time, rdata);

        // Write another value
        sel = 1; wr = 1; addr = 4'b0010; wdata = 16'h5A5A; // Write 5A5A to address 2
        #10;

        // Read from address 2
        sel = 1; wr = 0; addr = 4'b0010; // Read from address 2
        #10;
        $display("Time: %0t, rdata: %h", $time, rdata);

        // Finish simulation
        $finish;
    end
endmodule