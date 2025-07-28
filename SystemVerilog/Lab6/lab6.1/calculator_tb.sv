`timescale 1ps/1ps
program calculator_tb;
    calculator calc;
    real a = 10.0, b = 5.0;
    initial begin
        calc = new(a, b);
        $display("Adding %f and %f: %f", a, b, calc.add(a, b));
        $display("Subtracting %f from %f: %f", b, a, calc.sub(a, b));
        $display("Multiplying %f and %f: %f", a, b, calc.mult(a, b));
        $display("Dividing %f by %f: %f", a, b, calc.div(a, b));
        $display("Power of %d raised to %d: %d", 2, 3, calculator::power(2, 3));
        // Test division by zero
        $display("Dividing %f by 0: %f", a, calc.div(a, 0));

        $finish;
    end
    
endprogram