module preadder (
    input  wire [31:0] NumberA,
    input  wire [31:0] NumberB,
    input  wire        enable,
    output wire        SA,
    output wire        SB,
    output wire        C,
    output wire [6:0]  EO,
    output wire [26:0] MAOut,
    output wire [26:0] MBOut
);

	wire [35:0] NA_out_select, NB_out_select;
	wire [35:0] A_sub, B_sub;
	wire [35:0] A_nor, B_nor;
	wire [35:0] A_mix, B_mix;
	wire [35:0] MixAaux, MixBaux;
	wire [35:0] MuxA, MuxB;

	wire        SAOut, SBOut, SAsub, SBsub;
	wire        NComp, SComp;
	wire        Enor, Esub;
	wire [6:0]  EOOut;
	wire [26:0] MAnor, MBnor, MASub, MBSub;


	wire e_data;




	n_normal u_comp0 (
		 .NA(NumberA),
		 .NB(NumberB),
		 .Comp(NComp),
		 .SA(SAOut),
		 .SB(SBOut),
		 .EO(Enor),
		 .MA(MAnor),
		 .MB(MBnor)
	);

	n_subn u_comp1 (
		 .NA(A_sub),
		 .NB(B_sub),
		 .Comp(SComp),
		 .EO(Esub),
		 .SA(SAsub),
		 .SB(SBsub),
		 .MA(MASub),
		 .MB(MBSub)
	);

	norm u_norm (
		 .NumberA(A_mix),
		 .NumberB(B_mix),
		 .MA(MixAaux),
		 .MB(MixBaux)
	);

	demux u_demux (
		 .NA(NA_out_select),
		 .NB(NB_out_select),
		 .EData(e_data),
		 .NA0(A_sub),
		 .NB0(B_sub),
		 .NA1(A_nor),
		 .NB1(B_nor),
		 .NA2(A_mix),
		 .NB2(B_mix)
	);

	mux_ns u_mux_ns (
		 .NorA(A_nor),
		 .NorB(B_nor),
		 .MixA(MixAaux),
		 .MixB(MixBaux),
		 .EData(e_data),
		 .NA(MuxA),
		 .NB(MuxB)
	);

	selector u_selector (
		 .NumA(NumberA),
		 .NumB(NumberB),
		 .EN(enable),
		 .EData(e_data),
		 .NA(NA_out_select),
		 .NB(NB_out_select)
	);

	mux_adder u_mux_adder (
		 .NorSA(SAOut),
		 .NorSB(SBOut),
		 .SubSA(SAsub),
		 .SubSB(SBsub),
		 .CompN(NComp),
		 .CompS(SComp),
		 .NorE(Enor),
		 .SubE(Esub),
		 .NorMA(MAnor),
		 .NorMB(MBnor),
		 .SubMA(MASub),
		 .SubMB(MBSub),
		 .EData(e_data),
		 .SA(SA),
		 .SB(SB),
		 .C(C),
		 .E(EO),
		 .A(MAOut),
		 .B(MBOut)
	);

endmodule
