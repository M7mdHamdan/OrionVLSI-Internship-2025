`timescale 1ns/1ps
timeunit 1ns;
timeprecision 1ps;
module controller_tb;

    logic [2:0] opcode;
    logic rst_, clk, zero;
    logic mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr;

    controller uut (
        .opcode(opcode),
        .rst_(rst_),
        .clk(clk),
        .zero(zero),
        .mem_rd(mem_rd),
        .load_ir(load_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .load_ac(load_ac),
        .load_pc(load_pc),
        .mem_wr(mem_wr)
    );

    // Add state enum for monitoring
    typedef enum logic [2:0] { 
        INST_ADDR, INST_FETCH, INST_LOAD,
        IDLE, OP_ADDR, OP_FETCH, ALU_OP,
        STORE} state_monitor;
    
    state_monitor current_state_display;
    assign current_state_display = state_monitor'(uut.current_state);

    logic [6:0] current_output;
    assign current_output = {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr};
    
    typedef enum logic [2:0] { HLT, SKZ, ADD, AND, XOR, LDA, STO, JMP } opcode_names;
    opcode_names opcode_name;
    assign opcode_name = opcode_names'(opcode);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Task to display FSM cycles
    task display_fsm_cycles(input int cycles, input bit show_zero = 0);
        repeat(cycles) begin
            @(posedge clk);
            if (show_zero)
                $display("%0t ns | %s | %s(%03b) | zero=%b | %07b", 
                        $time, current_state_display.name(), opcode_name.name(), opcode, zero, current_output);
            else
                $display("%0t ns | %s | %s(%03b) | %07b", 
                        $time, current_state_display.name(), opcode_name.name(), opcode, current_output);
        end
    endtask

    // Main test sequence
    initial begin
        $display("=== Controller FSM Test ===");
        $display("Format: Time | State | Opcode | Outputs(mem_rd,load_ir,halt,inc_pc,load_ac,load_pc,mem_wr)");
        $display("================================================================");
        
        // Initialize
        rst_ = 0;
        zero = 0;
        opcode = 3'b000; // HLT
        
        // Release reset
        #10 rst_ = 1;
        
        // Monitor for several clock cycles to see FSM progression
        display_fsm_cycles(16);
        
        $display("\n=== Testing different opcodes ===");
        
        // Test each opcode through complete FSM cycles
        for (int i = 0; i < 8; i++) begin
            opcode = i;
            $display("\n--- Testing Opcode %s (%03b) ---", opcode_names'(i), i);
            
            // Reset FSM
            rst_ = 0;
            #10 rst_ = 1;
            
            // Run through several states
            display_fsm_cycles(10);
        end
        
        $display("\n=== Testing SKZ with zero=1 ===");
        opcode = 3'b001; // SKZ
        zero = 1;
        rst_ = 0;
        #10 rst_ = 1;
        
        display_fsm_cycles(10, 1);
        
        $finish;
    end

endmodule