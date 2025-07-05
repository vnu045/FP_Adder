module norm_vector (
    input  wire        SS,
    input  wire [27:0] MS,
    input  wire [7:0]  ES,
    input  wire        Co,
    output wire [31:0] N
);

    wire [22:0] Maux;
    wire [7:0]  Eaux;

    // Instantiate block_norm
    block_norm u_block_norm (
        .MS(MS),
        .ES(ES),
        .Co(Co),
        .M(Maux),
        .E(Eaux)
    );

    // Instantiate vector
    vector u_vector (
        .S(SS),
        .E(Eaux),
        .M(Maux),
        .N(N)
    );

endmodule
