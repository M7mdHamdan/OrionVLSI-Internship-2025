`timescale 1ps/1ps
program calculator_tb;
    calculator calc;
    real a = 10.0, b = 5.0;
    real add_result, sub_result, mult_result, div_result;
    int power_result;
    
    initial begin
        calc = new(a, b);
        
        calc.add(a, b, add_result);
        $display("Adding %f and %f: %f", a, b, add_result);
        
        calc.sub(a, b, sub_result);
        $display("Subtracting %f from %f: %f", b, a, sub_result);
        
        calc.mult(a, b, mult_result);
        $display("Multiplying %f and %f: %f", a, b, mult_result);
        
        calc.div(a, b, div_result);
        $display("Dividing %f by %f: %f", a, b, div_result);
        
        calculator::power(2, 3, power_result);
        $display("Power of %d raised to %d: %d", 2, 3, power_result);
        
        // Test division by zero
        calc.div(a, 0, div_result);
        $display("Dividing %f by 0: %f", a, div_result);

        $finish;
    end
    
endprogram