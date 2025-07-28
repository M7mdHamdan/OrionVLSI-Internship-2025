`timescale 1ps/1ps
class calculator;
    protected real result = 0;
    protected real a , b;
    function new(input real a, input real b);
        this.a = a;
        this.b = b;
    endfunction

    task add(input real a, input real b, output real result);
        result = a + b;
    endtask

    task sub(input real a, input real b, output real result);
        result = a - b;
    endtask

    task mult(input real a, input real b, output real result);
        result = a * b;
    endtask

    task div(input real a, input real b, output real result);
        if (b == 0) begin
            $display("Error: Division by zero");
            result = 0;
        end else begin
            result = real'(a) / real'(b);
        end
    endtask


    static task power(int base, int exp, output int result);
        if (exp == 0) begin
            result = 1;
            return;
        end
        if (exp < 0) begin
            $display("Error: Negative exponent not supported");
            result = 0;
            return;
        end
        result = 1;
        for (int i = 0; i < exp; i++) begin
            result *= base;
        end
    endtask

endclass