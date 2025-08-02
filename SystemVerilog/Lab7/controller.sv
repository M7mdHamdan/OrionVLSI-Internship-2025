`timescale 1ns/1ps
timeunit 1ns;
timeprecision 1ps;
module controller(
    input logic [2:0] opcode,
    input logic rst_, clk, zero,
    output logic mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr
);

typedef enum logic [2:0] { 
    INST_ADDR, INST_FETCH, INST_LOAD,
    IDLE, OP_ADDR, OP_FETCH, ALU_OP,
    STORE} state_c;
state_c current_state, next_state;

typedef enum logic [2:0] {
    HLT, SKZ, ADD, AND, XOR, LDA, STO, JMP
} opcode_c;

opcode_c opcode_fr;

logic ALUOP;

always_ff @(posedge clk or negedge rst_)
    begin
    if (!rst_)
        current_state <= INST_ADDR;
    else begin
        current_state <= next_state;
    end
    end

always_comb begin
    unique case(current_state)
        INST_ADDR: next_state = INST_FETCH;
        INST_FETCH: next_state = INST_LOAD;
        INST_LOAD: next_state = IDLE;
        IDLE: next_state = OP_ADDR;
        OP_ADDR: next_state = OP_FETCH;
        OP_FETCH: next_state = ALU_OP;
        ALU_OP: next_state = STORE;
        STORE: next_state = IDLE;
    endcase
    opcode_fr = HLT;
    ALUOP = 1'b0;
    unique case(opcode)
        3'b000: opcode_fr = HLT; 
        3'b001: opcode_fr = SKZ; 
        3'b010: begin opcode_fr = ADD; ALUOP = 1'b1; end
        3'b011: begin opcode_fr = AND; ALUOP = 1'b1; end
        3'b100: begin opcode_fr = XOR; ALUOP = 1'b1; end
        3'b101: begin opcode_fr = LDA; ALUOP = 1'b1; end
        3'b110: opcode_fr = STO;
        3'b111: opcode_fr = JMP; 
        default: opcode_fr = HLT; 
    endcase
end

always_comb begin
    // Default
    mem_rd = 0; load_ir = 0; halt = 0;
    inc_pc = 0; load_ac = 0; load_pc = 0; mem_wr = 0;
      
    unique case(current_state)
        INST_ADDR:begin end // No action needed;
        INST_FETCH: begin
            mem_rd = 1;
        end

        INST_LOAD: begin
            mem_rd = 1; load_ir = 1;
        end

        IDLE: begin
            mem_rd = 1; load_ir = 1;
        end

        OP_ADDR: begin
            halt = (opcode_fr == HLT);
            inc_pc = 1;
        end

        OP_FETCH: begin
            mem_rd = ALUOP;
        end

        ALU_OP: begin
            mem_rd = ALUOP;
            inc_pc = (opcode_fr == SKZ) && zero;
            load_ac = ALUOP;
            load_pc = (opcode_fr == JMP);
        end

        STORE: begin
            mem_rd = ALUOP;
            inc_pc = (opcode_fr == JMP);
            load_ac = ALUOP; 
            load_pc = (opcode_fr == JMP);
            mem_wr = (opcode_fr == STO);
        end
    endcase

end

endmodule
