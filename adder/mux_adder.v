module mux_adder(NorSA, NorSB, SubSA, SubSB, CompN, CompS, 
						NorE, SubE, NorMA, NorMB, SubMA, SubMB, 
						EData, 
						SA, SB, C, E, A, B);
input NorSA, NorSB, SubSA, SubSB, CompN, CompS;
input [7:0] NorE, SubE;
input [27:0] NorMA, NorMB, SubMA, SubMB;
input EData;
output reg SA, SB, C;
output reg [7:0] E;
output reg [27:0] A, B;

	always @(*)
	begin
		if (EData == 2'b01 || EData == 2'b10)
		begin 
			A = NorMA;
			B = NorMB;
			C = CompN;
			SA = NorSA;
			SB = NorSB;
			E = NorE;
		end 
		else if (EData == 2'b00)
		begin 
			A = SubMA;
			B = SubMB;
			C = CompS;
			SA = SubSA;
			SB = SubSB;
			E = SubE;
		end 
		else 
		begin 
			A = 28'bz;
			B = 28'bz;
			C = 1'bz;
			SA = 1'bz;
			SB = 1'bz;
			E = 8'bz;
		end
	end
endmodule 