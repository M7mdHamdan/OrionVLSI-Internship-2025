`timescale 1ps/1ps

class my_register;
    protected logic [7:0] data;

function new(input logic [7:0] data);
    this.data = data;
endfunction 

function void load(input logic [7:0] data);
    this.data = data;
endfunction 

function logic [7:0] get_data();
    return data;
endfunction 

virtual task shift();
endtask

endclass

class shiftRightRegister extends my_register;
    function new(input logic [7:0] data = 8'b00000000);
        super.new(data);
    endfunction
    virtual task shift();
        data = data >> 1;
    endtask
endclass

class shiftLeftRegister extends my_register;
    function new(input logic [7:0] data = 8'b00000000);
        super.new(data);
    endfunction
    virtual task shift();
        data = data << 1;
    endtask
endclass



