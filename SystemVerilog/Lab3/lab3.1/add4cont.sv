module add4cont (
    input logic [3:0] ina, inb,
    input logic cin,
    output logic cout,
    output logic [3:0] sum
);
assign {cout, sum} = ina + inb + cin;
endmodule