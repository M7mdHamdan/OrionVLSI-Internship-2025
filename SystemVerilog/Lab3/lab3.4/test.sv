module test;
reg a, b, c, d;
wire e;
and and1 (e, a, b, c);
initial begin
$monitor("%d d=%b,e=%b", $stime, d, e);
assign d = a & b & c;
a = 1;
b = 0;
c = 1;
#10;
force d = (a | b | c);
force e = (a | b | c);
#10 $stop;
release d;
release e;
#10 $finish;
end
endmodule

//we found out that we are overriding a driver with force
//and with release we are going back to the original driver
