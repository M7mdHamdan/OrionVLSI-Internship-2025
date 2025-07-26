`timescale 1ns/1ps
module slsr(sl, sr, din, clk, reset,Q);
input sl, sr, din, clk, reset;
output [7:0] Q;
reg [7:0] temp;

always @(posedge clk or posedge reset) 
begin
    if (reset) begin
        temp = 8'b0; // Reset the output to zero
    end else begin
        if (sl) begin
            temp = {temp[6:0], din}; // Shift left and insert din at LSB
        end else if (sr) begin
            temp = {din, temp[7:1]}; // Shift right and insert din at MSB
        end
    end
end
assign Q = temp;
endmodule