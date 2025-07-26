`timescale 1ns/1ps
module add4cont_tb;
    reg [3:0] ina, inb;
    reg cin;
    wire cout;
    wire [3:0] sum;

    // Instantiate the add4cont module
    add4cont FullAdder1 (
        .ina(ina),
        .inb(inb),
        .cin(cin),
        .cout(cout),
        .sum(sum)
    );

    initial begin
        // Initialize inputs
        ina = 4'b0000;
        inb = 4'b0000;
        cin = 0;

        // Apply test vectors
        #10; ina = 4'b0011; inb = 4'b0101; cin = 0; // 3 + 5 = 8
        #10; ina = 4'b1111; inb = 4'b0001; cin = 0; // 15 + 1 = 16
        #10; ina = 4'b1000; inb = 4'b0111; cin = 1; // 8 + 7 + 1 = 16

        // Finish simulation
        #10;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t, ina: %b, inb: %b, cin: %b, cout: %b, sum: %b", 
                 $time, ina, inb, cin, cout, sum);
    end
endmodule
