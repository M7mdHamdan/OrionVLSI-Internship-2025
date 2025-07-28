`timescale 1ps/1ps
class calculator;
    protected real a , b;
    function new(input real a, input real b);
        this.a = a;
        this.b = b;
    endfunction

    function real add(input real a, input real b);
        return a + b;
    endfunction

    function real sub(input real a, input real b);
        return a - b;
    endfunction

    function real mult(input real a, input real b);
        return a * b;
    endfunction

    function real div(input real a, input real b);
        if (b == 0) begin
            $display("Error: Division by zero");
            return 0;
        end
        return real'(a) / real'(b);
    endfunction

endclass