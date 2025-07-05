module fpadder (
	 input  wire clk, reset,
    input  wire [31:0] NumberA,
    input  wire [31:0] NumberB,
    input  wire        A_S,
    output wire [31:0] Result
);

    wire [27:0] MA_aux, MB_aux, Mout_aux;
    wire [7:0]  EOut_aux;
    wire        Comp_aux, Carry; 
    wire        SA_aux, SB_aux, S_aux;
    wire        enable_aux;
    wire [31:0] Ncase, Nadder;
	 
	 wire 		 A_S_case;
	 wire        A_S_case_adder;
    wire        SA_adder;
    wire        SB_adder;
    wire        C_adder;
    wire [6:0]  EO_adder;
    wire [26:0] MAOut_adder;
    wire [26:0] MBOut_adder;
	 wire [31:0] Ncase_adder;
	 wire			 EN_adder;
	 
    wire [31:0] Ncase_vector;
    wire        SS_vector;
    wire [27:0] MS_vector;
    wire [6:0]  EO_vector;
    wire        Co_vector;
    wire        EN_vector;


    // Component instances
	 
	 reg_case reg_casen (
        .clk          (clk),
        .reset        (reset),
        .A_in   (NumberA),
        .B_in   (NumberB),
        .A_S_in       (A_S),
        .A_out  (NumberA_pipe),
        .B_out  (NumberB_pipe),
        .A_S_out      (A_S_case)
    );

    n_case u_n_case (
        .NA(NumberA),
        .NB(NumberB),
        .EN(enable_aux),
        .S(Ncase)
    );
	 
    preadder u_preadder (
        .NumberA(NumberA),
        .NumberB(NumberB),
        .enable(enable_aux),
        .SA(SA_aux),
        .SB(SB_aux),
        .C(Comp_aux),
        .EO(EOut_aux),
        .MAOut(MA_aux),
        .MBOut(MB_aux)
    );
	 
	 reg_adder reg_addern (
        .clk            (clk),
        .reset          (reset),
        .A_S_case_in    (A_S_case),
        .SA_in          (SA_aux),
        .SB_in          (SB_aux),
        .C_in           (Comp_aux),
        .EO_in          (EOut_aux),
        .MAOut_in       (MA_aux),
        .MBOut_in       (MB_aux),
		  .S_in				(Ncase),
		  .EN_in				(enable_aux),
        .A_S_case_out   (A_S_case_adder),
        .SA_out         (SA_adder),
        .SB_out         (SB_adder),
        .C_out          (C_adder),
        .EO_out         (EO_adder),
        .MAOut_out      (MAOut_adder),
        .MBOut_out      (MBOut_adder),
		  .S_out				(Ncase_adder),
		  .EN_out			(EN_adder)
    );

    block_adder u_block_adder (
        .SA(SA_adder),
        .SB(SB_adder),
        .A(MAOut_adder),
        .B(MBOut_adder),
        .A_S(A_S_case_adder),
        .Comp(C_adder),
        .S(Mout_aux),
        .SO(S_aux),
        .Co(Carry)
    );
	 
	     // Instance pipeline_register_3
    reg_vector reg_vectorn (
        .clk         (clk),
        .reset       (reset),
        .Ncase_in    (Ncase_adder),
        .SS_in       (S_aux),
        .MS_in       (Mout_aux),
        .EO_in       (EO_adder),
        .Co_in       (Carry),
        .EN_in       (EN_adder),
        .Ncase_out   (Ncase_vector),
        .SS_out      (SS_vector),
        .MS_out      (MS_vector),
        .EO_out      (EO_vector),
        .Co_out      (Co_vector),
        .EN_out      (EN_vector)
    );


    norm_vector u_norm_vector (
        .SS(SS_vector),
        .MS(MS_vector),
        .ES(EO_vector),
        .Co(Co_vector),
        .N(Nadder)
    );

    mux_fpadder u_mux_fpadder (
        .N1(Ncase_vector),
        .N2(Nadder),
        .enable(EN_vector),
        .Result(Result)
    );


endmodule
