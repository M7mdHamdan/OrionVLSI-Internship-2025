`timescale 1ps/1ps

class my_register #(parameter DATA_WIDTH = 8);
    // Counts the number of my_register instances created
    static int unsigned counter = 0;
    protected logic [DATA_WIDTH-1:0] data;

function new(input logic [DATA_WIDTH-1:0] data);
    this.data = data;
    counter++;
endfunction 

function void load(input logic [DATA_WIDTH-1:0] data);
    this.data = data;
endfunction 

function logic [DATA_WIDTH-1:0] get_data();
    return data;
endfunction 

static function int NumOfInstances();
    return counter;
endfunction

virtual task shift();
endtask

endclass

class shiftRightRegister extends my_register;
    function new(input logic [DATA_WIDTH-1:0] data = 8'b00000000);
        super.new(data);
    endfunction
    
    virtual task shift();
        data = data >> 1;
    endtask
endclass

class shiftLeftRegister extends my_register;
    function new(input logic [DATA_WIDTH-1:0] data = 8'b00000000);
        super.new(data);
    endfunction
    
    virtual task shift();
        data = data << 1;
    endtask
endclass



