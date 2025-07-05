module shift_left (
    input  wire [27:0] T,      // Significand to shift
    input  wire [4:0]  Shft,   // Exponent's subtraction
    output wire [27:0] S       // Output
);

    // Internal signals
    wire [27:0] Z1, Z2, Z3, Z4, Z5;

    genvar i;

    // Stage 0: shift by 1
    generate
        for (i = 0; i < 28; i = i + 1) begin : shifter0
            if (i == 0) begin
                mux_n shifter0_0comp (
                    .A   (0),
                    .B   (T[i]),
                    .Sel (Shft[0]),
                    .Z   (Z1[i])
                );
            end else begin
                mux_n shifter0_icomp (
                    .A   (T[i-1]),
                    .B   (T[i]),
                    .Sel (Shft[0]),
                    .Z   (Z1[i])
                );
            end
        end
    endgenerate

    // Stage 1: shift by 2
    generate
        for (i = 0; i < 28; i = i + 1) begin : shifter1
            if (i < 2) begin
                mux_n shifter1_0comp (
                    .A   (0),
                    .B   (Z1[i]),
                    .Sel (Shft[1]),
                    .Z   (Z2[i])
                );
            end else begin
                mux_n shifter1_icomp (
                    .A   (Z1[i-2]),
                    .B   (Z1[i]),
                    .Sel (Shft[1]),
                    .Z   (Z2[i])
                );
            end
        end
    endgenerate

    // Stage 2: shift by 4
    generate
        for (i = 0; i < 28; i = i + 1) begin : shifter2
            if (i < 4) begin
                mux_n shifter2_0comp (
                    .A   (0),
                    .B   (Z2[i]),
                    .Sel (Shft[2]),
                    .Z   (Z3[i])
                );
            end else begin
                mux_n shifter2_icomp (
                    .A   (Z2[i-4]),
                    .B   (Z2[i]),
                    .Sel (Shft[2]),
                    .Z   (Z3[i])
                );
            end
        end
    endgenerate

    // Stage 3: shift by 8
    generate
        for (i = 0; i < 28; i = i + 1) begin : shifter3
            if (i < 8) begin
                mux_n shifter3_0comp (
                    .A   (0),
                    .B   (Z3[i]),
                    .Sel (Shft[3]),
                    .Z   (Z4[i])
                );
            end else begin
                mux_n shifter3_icomp (
                    .A   (Z3[i-8]),
                    .B   (Z3[i]),
                    .Sel (Shft[3]),
                    .Z   (Z4[i])
                );
            end
        end
    endgenerate

    // Stage 4: shift by 16
    generate
        for (i = 0; i < 28; i = i + 1) begin : shifter4
            if (i < 16) begin
                mux_n shifter4_0comp (
                    .A   (0),
                    .B   (Z4[i]),
                    .Sel (Shft[4]),
                    .Z   (Z5[i])
                );
            end else begin
                mux_n shifter4_icomp (
                    .A   (Z4[i-16]),
                    .B   (Z4[i]),
                    .Sel (Shft[4]),
                    .Z   (Z5[i])
                );
            end
        end
    endgenerate

    assign S = Z5;

endmodule
