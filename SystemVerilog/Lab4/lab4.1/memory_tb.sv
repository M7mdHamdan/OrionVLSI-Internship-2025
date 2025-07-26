`timescale 1ps/1ps
`include "/home/Trainee3/mHamdan/SystemVerilog/Lab2/MyMem.sv"
module memory_tb;
    reg [15:0] wdata;
    reg sel, wr, clk, reset;
    reg [3:0] addr;
    wire [15:0] rdata;

    MyMem semaphore_example (
        .wdata(wdata),
        .sel(sel),
        .wr(wr),
        .clk(clk),
        .reset(reset),
        .addr(addr),
        .rdata(rdata)
    );
    task write_mem(input [3:0] address, input [15:0] data);
        sel = 1;
        wr = 1;
        addr = address;
        wdata = data;
        #5; // Wait for write operation to complete

    endtask

    task read_mem(input [3:0] address);
        sel = 1;
        wr = 0; // Disable write
        addr = address;
        #4; // Wait for read operation to complete
    endtask 

    initial begin
        // Initialize inputs
        wdata = 16'b0;
        sel = 0;
        wr = 0;
        clk = 0;
        reset = 0;
        addr = 4'b0000;

        $monitor("Time: %0t, rdata: %b", $time, rdata);

        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        write_mem(4'b0000, 16'hA5A5); // Write A5A5 to address 0
        $display("Time: %0t, Written to address 0: %h", $time, 16'hA5A5);
        write_mem(4'b0001, 16'h5A5A); // Write 5A5A to address 1
        $display("Time: %0t, Written to address 1: %h", $time, 16'h5A5A);
        #10;
        read_mem(4'b0000); // Read from address 0
        $display("Time: %0t, Read from address 0: %h", $time, rdata);
        read_mem(4'b0001); // Read from address 1
        $display("Time: %0t, Read from address 1: %h", $time, rdata);

        #10;
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