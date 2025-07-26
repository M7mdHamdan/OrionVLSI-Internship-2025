`timescale 1ps/1ps
module prbs (random_out, clk, reset);//rand sys verilog keyword
input clk, reset;
output random_out;
reg [3:0] shift_reg;
always @(posedge clk or posedge reset) begin
  if (reset) begin
    shift_reg <= 4'b0001;
  end else begin
    shift_reg <= {shift_reg[2:0], shift_reg[3] ^ shift_reg[0]};
  end
end

// Output assignment - continuous assignment
assign random_out = shift_reg[3];
endmodule
