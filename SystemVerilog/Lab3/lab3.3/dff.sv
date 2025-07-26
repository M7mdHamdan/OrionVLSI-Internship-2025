`timescale 1ps/1ps
module dff (
    input logic d,
    input logic clk,
    input logic clear,
    input logic preset,
    output logic q
);
always_ff @(posedge clk or posedge clear or posedge preset) begin
    if (!clear) begin
        q <= 1'b0; //
    end else if (!preset) begin
        q <= 1'b1; //
    end else begin
        q <= d; // Capture input on clock edge
    end

end
endmodule