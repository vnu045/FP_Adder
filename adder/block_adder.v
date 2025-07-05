// Block Adder Module

module block_adder (
    input wire SA, SB,            // Sign A, Sign B
    input wire [27:0] A, B,       // Numbers A and B
    input wire A_S,               // Add (0) / Sub (1)
    input wire Comp,              // Comparison
    output wire [27:0] S,         // Output
    output wire SO,               // Output's sign
    output wire Co                // Carry out
);

	// Internal signals
	wire [27:0] Aa_aux, Bb_aux, S_aux;
	wire AS_aux, SO_aux, Co_aux;

	// Instantiate signout module
	signout component00 (
		 .SA(SA), .SB(SB), .A(A), .B(B), .A_S(A_S), .Comp(Comp),
		 .Aa(Aa_aux), .Bb(Bb_aux), .AS(AS_aux), .SO(SO_aux)
	);

	// Instantiate adder module
	adder component01 (
		 .A(Aa_aux), .B(Bb_aux), .A_S(AS_aux),
		 .S(S_aux), .Co(Co_aux)
	);

	// Compute final output sum
	assign S = (AS_aux & SO_aux) ? ((~S_aux) + 1'b1) : S_aux;

	// Compute final carry-out
	assign Co = ((SB ^ A_S) != SA) ? 0 : Co_aux;

	// Compute output sign
	assign SO = SO_aux;

endmodule