`timescale 1ps/1ps

program my_register_tb;
    my_register my_reg;
    shiftRightRegister sr;
    shiftLeftRegister sl;
    // const logic [7:0] d = 8'b00000000;
    initial begin
        my_reg = new(8'b00000000);
        $display("Unit data %b", my_reg.get_data());
        my_reg.load(8'b00000001);
        $display("After loading 01: %b", my_reg.get_data());
        my_reg.load(8'hAA);
        $display("After loading AA: %b", my_reg.get_data());

        $display("Testing shift registers");
        sr = new;
        sl = new(8'b00000000);

        $display("Current data for shiftRight %08b",sr.get_data());
        $display("Current data for shiftLeft %08b",sl.get_data());
        sl.load(8'b00000001);
        sr.load(8'b10000000);
        $display("After load Current data for shiftRight %08b",sr.get_data());
        $display("After load Current data for shiftLeft %08b",sl.get_data());

        sr.shift();
        sl.shift();
        $display("After shift Current data for shiftRight %08b",sr.get_data());
        $display("After shift Current data for shiftLeft %08b",sl.get_data());


        $finish;
    end
endprogram