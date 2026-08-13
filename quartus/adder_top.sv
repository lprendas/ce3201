module adder_top (input logic [3:0] a, input logic [3:0] b, output logic [4:0] sum);

    adder adder_inst (
        .a(a),
        .b(b),
        .sum(sum)
    );
endmodule