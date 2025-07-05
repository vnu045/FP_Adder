// Adder module

module adder (
    input wire [27:0] A, B,  // Number A and B
    input wire A_S,          // Add (0) / Sub (1)
    output wire [27:0] S,    // Output
    output wire Co           // Carry out
);

	// Internal signals
	wire [27:0] B1, S_aux, aux;

	// Generate complemented B based on A_S
	genvar i;
	generate
		 for (i = 0; i < 28; i = i + 1) begin : Compl
			  assign B1[i] = B[i] ^ A_S;
		 end
	endgenerate

	// Instantiate CLA components
	generate
		 for (i = 0; i < 28; i = i + 1) begin : sumador
			  if (i == 0) begin
					cla sumador_0comp (
						 .A(A[i]), .B(B1[i]), .Cin(A_S),
						 .S(S_aux[i]), .Cout(aux[i])
					);
			  end else begin
					cla sumador_icomp (
						 .A(A[i]), .B(B1[i]), .Cin(aux[i-1]),
						 .S(S_aux[i]), .Cout(aux[i])
					);
			  end
		 end
	endgenerate

	// Assign outputs
	assign S = S_aux;
	assign Co = aux[27];

endmodule
