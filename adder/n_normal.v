module n_normal (
    input  wire [36:0] NA,
    input  wire [36:0] NB,
    output wire        Comp,
    output wire        SA,
    output wire        SB,
    output wire [7:0]  EO,
    output wire [27:0] MA,
    output wire [27:0] MB
);

// Internal signals
wire [27:0] Mshft_aux;
wire [4:0]  Dexp_aux;

// Component instantiation: comp_exp
comp_exp comp0 (
    .NA (NA),
    .NB (NB),
    .SA      (SA),
    .SB      (SB),
    .Emax    (EO),
    .Mmax    (MA),
    .Mshift   (Mshft_aux),
    .Dexp    (Dexp_aux),
    .Comp    (Comp)
);

// Component instantiation: shift
shift comp1 (
    .T    (Mshft_aux),
    .Shft (Dexp_aux),
    .S    (MB)
);

endmodule
