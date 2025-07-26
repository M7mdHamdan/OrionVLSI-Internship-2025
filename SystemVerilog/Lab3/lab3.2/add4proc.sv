`timescale 1ps/1ps
module add4proc (
    input logic [3:0] ina, inb,
    input logic cin,
    output logic cout,
    output logic [3:0] sum
);
// Combinational procedural (equivalent to your assign)
always_comb begin
    {cout, sum} = ina + inb + cin;
end 
endmodule