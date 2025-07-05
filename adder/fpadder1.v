////////////////////////////////////////////////////////////
//  Floating‑point Adder (pipelined)
//  ‑ 3 pipeline stages with explicit register modules:
//      * reg_case    : stage‑0 (input align + op select)
//      * reg_adder   : stage‑1 (outputs of pre‑adder)
//      * reg_vector  : stage‑2 (adder + rounding)
////////////////////////////////////////////////////////////

module fpadder1 (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] NumberA,
    input  wire [31:0] NumberB,
    input  wire        A_S,        // 0 = add, 1 = sub
    output wire [31:0] Result
);
    //------------------------------------------------------
    // Stage‑0 wires (after reg_case)
    //------------------------------------------------------
    wire [31:0] NumberA_s0, NumberB_s0;
    wire        A_S_s0;

    //------------------------------------------------------
    // Stage‑1 wires (outputs of n_case / preadder)
    //------------------------------------------------------
    wire        enable_s1;
    wire [31:0] Ncase_s1;
    wire        SA_s1, SB_s1, Comp_s1;
    wire [7:0]  EO_s1;
    wire [27:0] MA_s1, MB_s1;

    //------------------------------------------------------
    // Stage‑2 wires (after block_adder)
    //------------------------------------------------------
    wire        A_S_s2;
    wire        SA_s2, SB_s2, C_s2;
    wire [6:0]  EO_s2;
    wire [26:0] MA_s2, MB_s2;
    wire [31:0] Ncase_s2;
    wire        EN_s2;
    wire [27:0] Mout_s2;
    wire        SO_s2, Co_s2;

    //------------------------------------------------------
    // Stage‑3 wires (vector normalisation)
    //------------------------------------------------------
    wire [31:0] Ncase_s3;
    wire        SS_s3, EN_s3;
    wire [27:0] MS_s3;
    wire [6:0]  EO_s3;
    wire        Co_s3;
    wire [31:0] Nadder_s3;

    //------------------------------------------------------
    //  REGISTER STAGE‑0 : Input synchronisation
    //------------------------------------------------------
    reg_case u_reg_case (
        .clk    (clk),
        .reset  (rst),
        .A_in   (NumberA),
        .B_in   (NumberB),
        .A_S_in (A_S),
        .A_out  (NumberA_s0),
        .B_out  (NumberB_s0),
        .A_S_out(A_S_s0)
    );

    //------------------------------------------------------
    //  n_case  (detect specials) – combinational
    //------------------------------------------------------
    n_case u_n_case (
        .NA (NumberA_s0),
        .NB (NumberB_s0),
        .EN (enable_s1),     // enable for datapath when both normal/sub
        .S  (Ncase_s1)       // result for special cases
    );

    //------------------------------------------------------
    //  pre‑adder (align mantissas, exponent compare)
    //------------------------------------------------------
    preadder u_preadder (
        .NumberA (NumberA_s0),
        .NumberB (NumberB_s0),
        .enable  (enable_s1),
        .SA      (SA_s1),
		  .SB      (SB_s1),
        .C       (Comp_s1),
        .EO      (EO_s1),
        .MAOut   (MA_s1),
        .MBOut   (MB_s1)
    );

    //------------------------------------------------------
    //  REGISTER STAGE‑1 : latch outputs of pre‑adder
    //------------------------------------------------------
    reg_adder u_reg_adder (
        .clk            (clk),
        .reset          (rst),
        .A_S_case_in    (A_S_s0),
        .SA_in          (SA_s1),
        .SB_in          (SB_s1),
        .C_in           (Comp_s1),
        .EO_in          (EO_s1),
        .MAOut_in       (MA_s1),
        .MBOut_in       (MB_s1),
        .S_in           (Ncase_s1),
        .EN_in          (enable_s1),
        //--------------------------------------------------
        .A_S_case_out   (A_S_s2),
        .SA_out         (SA_s2),
        .SB_out         (SB_s2),
        .C_out          (C_s2),
        .EO_out         (EO_s2),
        .MAOut_out      (MA_s2),
        .MBOut_out      (MB_s2),
        .S_out          (Ncase_s2),
        .EN_out         (EN_s2)
    );

    //------------------------------------------------------
    //  block_adder : add/sub aligned mantissas
    //------------------------------------------------------
    block_adder u_block_adder (
        .SA   (SA_s2),
        .SB   (SB_s2),
        .A    (MA_s2),
        .B    (MB_s2),
        .A_S  (A_S_s2),
        .Comp (C_s2),
        .S    (Mout_s2),
        .SO   (SO_s2),
        .Co   (Co_s2)
    );

    //------------------------------------------------------
    // REGISTER STAGE‑2 : latch adder outputs
    //------------------------------------------------------
    reg_vector u_reg_vec (
        .clk       (clk),
        .reset     (rst),
        .Ncase_in  (Ncase_s2),
        .SS_in     (SO_s2),
        .MS_in     (Mout_s2),
        .EO_in     (EO_s2),
        .Co_in     (Co_s2),
        .EN_in     (EN_s2),
        //--------------------------------------------------
        .Ncase_out (Ncase_s3),
        .SS_out    (SS_s3),
        .MS_out    (MS_s3),
        .EO_out    (EO_s3),
        .Co_out    (Co_s3),
        .EN_out    (EN_s3)
    );

    //------------------------------------------------------
    //  norm_vector : final normalisation & packing
    //------------------------------------------------------
    norm_vector u_norm_vector (
        .SS (SS_s3),
        .MS (MS_s3),
        .ES (EO_s3),
        .Co (Co_s3),
        .N  (Nadder_s3)
    );

    //------------------------------------------------------
    //  Final mux: choose special‑case vs. adder result
    //------------------------------------------------------
    mux_fpadder u_mux (
        .N1    (Ncase_s3),   // result from n_case pipeline
        .N2    (Nadder_s3),  // result from datapath
        .enable(EN_s3),
        .Result(Result)
    );
endmodule