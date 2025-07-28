`timescale 1ps/1ps
`include "/home/Trainee3/mHamdan/SystemVerilog/Lab2/MyMem.sv"
module memory_tb;
    reg [15:0] wdata;
    reg sel, wr, clk, reset;
    reg [3:0] addr;
    wire [15:0] rdata;

    MyMem mailbox_example (
        .wdata(wdata),
        .sel(sel),
        .wr(wr),
        .clk(clk),
        .reset(reset),
        .addr(addr),
        .rdata(rdata)
    );
    typedef struct {
        int value;
        string name;
    } MailboxItem;
    mailbox mb = new();

    task putInMailbox (int value, string name);
        MailboxItem item;
        item.value = value;
        item.name = name;
        mb.put(item);
        $display("Task1: Value %0d put in mailbox with name '%s' mailbox size = %d", item.value, item.name, mb.num());
    endtask


    task getFromMailbox ();
    MailboxItem item;
        mb.get(item);
        $display("Task2: Value %0d received from mailbox with name '%s' mailbox size is = %0d", item.value, item.name, mb.num());
        endtask

    initial begin
        wdata = 16'b0;
        sel = 0;
        wr = 0;
        clk = 0;
        reset = 0;
        addr = 4'b0000;

        reset = 1;
        #10;
        reset = 0;
        fork
            begin
                putInMailbox(10, "Task1_Name");
                putInMailbox(20, "Task2_Name");
        
            end
            begin
                getFromMailbox();
                getFromMailbox();
            end
        join
        #10;
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