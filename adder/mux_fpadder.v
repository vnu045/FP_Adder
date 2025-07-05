module mux_fpadder (
    input  wire [31:0] N1,
    input  wire [31:0] N2,
    input  wire        enable,
    output wire [31:0] Result
);

    assign Result = (enable == 0) ? N1 : N2;

endmodule
