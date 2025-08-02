class alu_sequence_item extends uvm_sequence_item;

    //  Group: Variables
    rand logic rst;
    rand logic [31:0] A;  // operand 1 
    rand logic [31:0] B;  // operand 2 

    rand logic [2:0] Opcode;  // opcode 

     logic [31:0] Result;  // Result 
     logic Error;  // Result

    // Utility and Field macros
    `uvm_object_utils_begin(alu_sequence_item)
        `uvm_field_int(rst, UVM_ALL_ON)
        `uvm_field_int(A, UVM_ALL_ON)
        `uvm_field_int(B, UVM_ALL_ON)
        `uvm_field_int(Opcode, UVM_ALL_ON)
        `uvm_field_int(Result, UVM_ALL_ON)
        `uvm_field_int(Error, UVM_ALL_ON)
    `uvm_object_utils_end


    //  Constructor: new
    function new(string name = "alu_sequence_item");
        super.new(name);
    endfunction: new
    
endclass: alu_sequence_item
