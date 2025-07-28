`timescale 1ps/1ps
class my_register;
    protected logic [7:0] data;

function new(logic [7:0] data);
    this.data = data;
endfunction 

function void load(logic [7:0] data);
    this.data = data;
endfunction 

function logic [7:0] get_data();
    return data;
endfunction 

virtual function void shift();
endfunction

endclass



