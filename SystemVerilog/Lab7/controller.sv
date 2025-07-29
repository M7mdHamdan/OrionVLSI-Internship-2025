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

// int unsigned pc;

always_ff @(posedge clk or negedge rst_ or posedge zero)
    begin
    if (zero)
        opcode_fr <= HLT;
    if (!rst_)
        current_state <= INST_ADDR;
    else begin
        current_state <= next_state;
        // inc_pc <= inc_pc + 4;
    end
    end

always_comb begin
    case(current_state)
        INST_ADDR: next_state = INST_FETCH;
        INST_FETCH: next_state = INST_LOAD;
        INST_LOAD: next_state = IDLE;
        IDLE: next_state = OP_ADDR;
        OP_ADDR: next_state = OP_FETCH;
        OP_FETCH: next_state = ALU_OP;
        ALU_OP: next_state = STORE;
        STORE: next_state = IDLE;
    endcase
    case(opcode)
        3'b000: opcode_fr = HLT; 
        3'b001: opcode_fr = SKZ; 
        3'b010: opcode_fr = ADD; 
        3'b011: opcode_fr = AND; 
        3'b100: opcode_fr = XOR; 
        3'b101: opcode_fr = LDA; 
        3'b110: opcode_fr = STO;
        3'b111: opcode_fr = JMP; 
        default: opcode_fr = HLT; 
    endcase
end

always_comb begin
    case(current_state)
        INST_ADDR: begin
            mem_rd = 0; load_ir = 0; halt = 0;
            inc_pc = 0; load_ac = 0; load_pc = 0; mem_wr = 0;
        end
        INST_FETCH: begin
            mem_rd = 1; load_ir = 0; halt = 0;
            inc_pc = 0; load_ac = 0; load_pc = 0; mem_wr = 0;
        end
        INST_LOAD: begin
            mem_rd = 1; load_ir = 1; halt = 0;
            inc_pc = 0; load_ac = 0; load_pc = 0; mem_wr = 0;
        end
        IDLE: begin
            mem_rd = 1; load_ir = 1; halt = 0;
            inc_pc = 0; load_ac = 0; load_pc = 0; mem_wr = 0;
        end
        OP_ADDR: begin
            mem_rd = 0; load_ir = 0; halt = HLT;
            inc_pc = 1; load_ac = 0; load_pc = 0; mem_wr = 0;
        end
        //needs some fixing here
        OP_FETCH: begin
            mem_rd = ALUOP; load_ir = 0; halt = 0;
            inc_pc = 0; load_ac = 0; load_pc = 0; mem_wr = 0;
        end
        ALU_OP: begin
            mem_rd = 0; load_ir = 0; halt = 0;
            inc_pc = 0; load_ac = 1; load_pc = 0; mem_wr = 0;
        end
        STORE: begin
            mem_rd = 0; load_ir = 0; halt = 0;
            inc_pc = 0; load_ac = 0; load_pc = 0; mem_wr = 1;
        end

end

endmodule
