module shift (
    input  wire [27:0] T,
    input  wire [4:0]  Shft,
    output wire [27:0] S
);

    wire [27:0] Z1, Z2, Z3, Z4, Z5;

    // Stage 0
    genvar i;
    generate
        for (i = 0; i < 28; i = i + 1) begin : Compl
            if (i == 0) begin : shifter0_0
                mux_n shifter0_0comp (
                    .A(0),
                    .B(T[27]),
                    .Sel(Shft[0]),
                    .Z(Z1[27])
                );
            end
            else begin : shifter0_i
                mux_n shifter0_icomp (
                    .A(T[27 - (i - 1)]),
                    .B(T[27 - i]),
                    .Sel(Shft[0]),
                    .Z(Z1[27 - i])
                );
            end
        end
    endgenerate

    // Stage 1
    generate
        for (i = 0; i < 28; i = i + 1) begin : stage1
            if ((i >= 0) && (i < 2)) begin : shifter1_0
                mux_n shifter1_0comp (
                    .A(0),
                    .B(Z1[27 - i]),
                    .Sel(Shft[1]),
                    .Z(Z2[27 - i])
                );
            end
            else begin : shifter1_i
                mux_n shifter1_icomp (
                    .A(Z1[27 - (i - 2)]),
                    .B(Z1[27 - i]),
                    .Sel(Shft[1]),
                    .Z(Z2[27 - i])
                );
            end
        end
    endgenerate

    // Stage 2
    generate
        for (i = 0; i < 28; i = i + 1) begin : stage2
            if ((i >= 0) && (i < 4)) begin : shifter2_0
                mux_n shifter2_0comp (
                    .A(0),
                    .B(Z2[27 - i]),
                    .Sel(Shft[2]),
                    .Z(Z3[27 - i])
                );
            end
            else begin : shifter2_i
                mux_n shifter2_icomp (
                    .A(Z2[27 - (i - 4)]),
                    .B(Z2[27 - i]),
                    .Sel(Shft[2]),
                    .Z(Z3[27 - i])
                );
            end
        end
    endgenerate

    // Stage 3
    generate
        for (i = 0; i < 28; i = i + 1) begin : stage3
            if ((i >= 0) && (i < 8)) begin : shifter3_0
                mux_n shifter3_0comp (
                    .A(0),
                    .B(Z3[27 - i]),
                    .Sel(Shft[3]),
                    .Z(Z4[27 - i])
                );
            end
            else begin : shifter3_i
                mux_n shifter3_icomp (
                    .A(Z3[27 - (i - 8)]),
                    .B(Z3[27 - i]),
                    .Sel(Shft[3]),
                    .Z(Z4[27 - i])
                );
            end
        end
    endgenerate

    // Stage 4
    generate
        for (i = 0; i < 28; i = i + 1) begin : stage4
            if ((i >= 0) && (i < 16)) begin : shifter4_0
                mux_n shifter4_0comp (
                    .A(0),
                    .B(Z4[27 - i]),
                    .Sel(Shft[4]),
                    .Z(Z5[27 - i])
                );
            end
            else begin : shifter4_i
                mux_n shifter4_icomp (
                    .A(Z4[27 - (i - 16)]),
                    .B(Z4[27 - i]),
                    .Sel(Shft[4]),
                    .Z(Z5[27 - i])
                );
            end
        end
    endgenerate

    // Final output
    assign S = Z5;

endmodule
