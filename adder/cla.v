// Adder Carry LookAhead

module cla (
    input wire A, B, Cin,
    output wire S, Cout
);

	// Signal declaration
	wire c_g, c_p;

	// Carry generation and propagation
	assign c_g = A & B;  // Carry generate
	assign c_p = A ^ B;  // Carry propagate

	// Compute carry out and sum
	assign Cout = c_g | (c_p & Cin);
	assign S = c_p ^ Cin;

endmodule
