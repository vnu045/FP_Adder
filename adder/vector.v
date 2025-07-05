module vector(
	input wire S,
	input wire [7:0] E,
	input wire [22:0] M,
	output wire [31:0] N
);
	assign N = {S, E, M};
endmodule
