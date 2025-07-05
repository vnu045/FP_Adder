module norm (
    input  [36:0] NumberA,
    input  [36:0] NumberB,
    output wire [36:0] MA,
    output reg [36:0] MB
);

    wire [4:0] Zcount_aux;
    wire [27:0] MB_aux;
    reg [7:0] EB;
    wire [36:0] NumberB_aux;
    wire [36:0] MA_aux;  // <== wire trung gian cho MA

	// Module instantiations
	zero u_zero (
		 .T      (NumberB_aux[27:0]),
		 .Zcount (Zcount_aux)
	);

	shift_left u_shift_left (
		 .T    (NumberB_aux[27:0]),
		 .Shft (Zcount_aux),
		 .S    (MB_aux)
	);

	comp u_comp (
		 .NumberA (NumberA),
		 .NumberB (NumberB),
		 .NA      (MA),
		 .NB      (NumberB_aux)
	);

	// Process block
	always @(*) begin
		 if (Zcount_aux !== 5'bz) begin
			  EB[7:5] <= 3'b000;
			  EB[4:0] <= Zcount_aux;

			  MB[27:0] <= {MB_aux[27:1], 1'b1}; // Shift right by 1 and insert '1'
		 end else begin
			  EB <= 8'bz;
			  MB[27:0] <= MB_aux[27:0];
		 end

		 MB[35:28] <= EB;             // Attach exponent bits
		 MB[36]    <= NumberB_aux[36]; // Attach sign bit
	end
endmodule

