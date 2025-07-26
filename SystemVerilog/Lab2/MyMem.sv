`timescale 1ps/1ps
module MyMem (
    input bit [15:0] wdata,
    input bit sel, wr, clk , reset,
    input bit [3:0] addr,
    output bit [15:0] rdata
);

reg [15:0] mem [0:3]; // 16x4 memory
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset memory
        for (int i = 0; i < 4; i++) begin
            mem[i] <= 16'b0;
        end
    end else if (wr && sel) begin
        mem[addr] <= wdata;
    end
end

assign rdata = (sel) ? mem[addr] : 16'bz;

endmodule
