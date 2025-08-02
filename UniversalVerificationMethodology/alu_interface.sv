interface ALU_Interface(input logic clk, rst);
  // Input and output signals
  logic signed [31:0] A; // Operand 1
  logic [31:0] B; // Operand 2
  logic [2:0] Opcode; // Opcode
  logic [31:0] Result; // Output result
  logic Error; // Error flag for overflow

clocking DRIVER_CB@ (negedge clk);
  default input #1 output #0;
  output A;
  output B;
  output Opcode;
endclocking

clocking MONITOR_CB@ (posedge clk);
    default input #0 output #1;
    input A;
    input B;
    input Opcode;
    input Result;
    input Error;
endclocking

// Modports
modport DRIVER_MOD (clocking DRIVER_CB, input clk);
modport MONITOR_MOD (clocking MONITOR_CB, input clk);

endinterface