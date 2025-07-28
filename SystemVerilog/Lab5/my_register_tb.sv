`timescale 1ps/1ps
program my_register_tb;
    initial begin
        my_register my_reg;
        my_reg = new(8'b00000000);
        $display("Unit data %b", my_reg.get_data());
        my_reg.load(8'b00000001);
        $display("After loading 01: %b", my_reg.get_data());
        my_reg.load(8'hAA);
        $display("After loading AA: %b", my_reg.get_data());
        $finish;
    end
endprogram