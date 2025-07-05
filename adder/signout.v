module signout (
    input  wire       SA,         // Sign A
    input  wire       SB,         // Sign B
    input  wire [27:0] A,          // Number A
    input  wire [27:0] B,          // Number B
    input  wire       A_S,        // Add (0) or Sub (1)
    input  wire       Comp,       // Determine largest number
    output reg  [27:0] Aa,         // Number A (output)
    output reg  [27:0] Bb,         // Number B (output)
    output reg        AS,         // Complement sign
    output reg        SO          // Output's Sign
);

	// ==================== Signal declaration ====================
	wire       SB_aux;
	wire [27:0] Aaux, Baux;

	// ==================== Assignments ====================

	// Sign B because of the operation
	assign SB_aux = SB ^ A_S;

	// Determine Output's sign
	always @(*) begin
		 if (Comp == 1)
			  SO <= SA;         // A > B -> Sign A
		 else if (Comp == 0)
			  SO <= SB_aux;     // B > A -> Sign B
		 else
			  SO <= 1'bz;        // Undefined case (optional to add)
	end

	// Complement to 1 is needed when the signs are different
	always @(*) begin
		 if (SA != SB_aux)
			  AS <= 1;
		 else
			  AS <= 0;
	end

	// Selection of Aaux and Baux
	assign Aaux = (Comp == 1) ? A : B;
	assign Baux = (Comp == 1) ? B : A;

	// ==================== Main process ====================
	always @(*) begin
		 if ((SA ^ SB_aux) == 0) begin
			  // Sign A == Sign B -> Nothing changes
			  Aa <= Aaux;
			  Bb <= Baux;
		 end
		 else if (SA == 1 && SB_aux == 0) begin
			  // Sign A = 1, Sign B = 0
			  Aa <= Baux;
			  Bb <= Aaux;
		 end
		 else if (SA == 0 && SB_aux == 1) begin
			  // Sign A = 0, Sign B = 1
			  Aa <= Aaux;
			  Bb <= Baux;
		 end
		 else begin
			  Aa <= 'bz;   // Undefined case (optional to add)
			  Bb <= 'bz;
		 end
	end

endmodule
