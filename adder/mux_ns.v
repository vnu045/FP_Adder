module mux_ns(NorA, NorB, MixA, MixB, EData, NA, NB);

input [36:0] NorA, NorB, MixA, MixB;
input [1:0] EData;
output reg [36:0] NA, NB;

	always @(*)
	begin
	if (EData == 2'b01) 
		begin 
		NA <= NorA;
		NB <= NorB;
		end 
	else if (EData == 2'b10) 
		begin 
		NA <= MixA;
		NB <= MixB;
		end 
	else 
		begin 
		NA <= 37'bz;
		NB <= 37'bz;
		end 
	end 
endmodule 