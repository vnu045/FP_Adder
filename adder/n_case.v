module n_case(NA, NB, EN, S);

	input [31:0] NA, NB;
	output reg EN;
	output reg [31:0] S;

	reg [2:0] outA, outB;
	wire [7:0] EA, EB;
	wire [22:0] MA, MB;
	wire SA, SB;
	reg SS;
	reg [7:0] ES;
	reg [22:0] MS;

	assign SA = NA[31];
	assign SB = NB[31];
	assign EA = NA[30:23];
	assign EB = NB[30:23];
	assign MA = NA[22:0];
	assign MB = NB[22:0];

	always @(*)
	begin
		// Xác định loại số cho A
		if (EA == 8'h00 && MA == 0)
			 outA = 3'b000; // Zero
		else if (EA == 8'h00 && MA > 0)
			 outA = 3'b001; // Subnormal
		else if (EA > 8'h00 && EA < 8'hFF && MA > 0)
			 outA = 3'b011; // Normal
		else if (EA == 8'hFF && MA == 0)
			 outA = 3'b100; // Infinity
		else if (EA == 8'hFF && MA > 0)
			 outA = 3'b110; // NaN
		else
			 outA = 3'b000;

			  // Xác định loại số cho B
		if (EB == 8'h00 && MB == 0)
			 outB = 3'b000; // Zero
		else if (EB == 8'h00 && MB > 0)
			 outB = 3'b001; // Subnormal
		else if (EB > 8'h00 && EB < 8'hFF && MB > 0)
			 outB = 3'b011; // Normal
		else if (EB == 8'hFF && MB == 0)
			 outB = 3'b100; // Infinity
		else if (EB == 8'hFF && MB > 0)
			 outB = 3'b110; // NaN
		else
			 outB = 3'b000;
			 
			 
			 
		// if A and B are normal or subnormal, en = 1
		if(outA[0] && outB[0]) EN = 1;
		else EN = 0;
		
		
		
		// Zero
		if(outA == 3'b000) 
		begin 
			SS <= SB;
			ES <= EB;
			MS <= MB;
		end 
		else if (outB == 3'b000) 
		begin 
			SS <= SA;
			ES <= EA;
			MS <= MA;
		end 
		
		
		//Infinite
		if(outA[0] == 1 && outB == 3'b100)
		begin 
			SS <= SB;
			ES <= EB;
			MS <= MB;
		end 
		else if ((outB[0] == 1 && outA) == 3'b100)
		begin 
			SS <= SA;
			ES <= EA;
			MS <= MA;
		end 	
		if ((outA == 3'b100 && outB == 3'b100) && SA == SB)
		begin 
			SS <= SA;
			ES <= EA;
			MS <= MA;
		end 
		
		
		
		// NaN
		else if ((outA == 3'b100 && outB == 3'b100) && SA != SB)
		begin
			SS <= 1;
			ES <= 8'hFF;
			MS <= 23'd1;
		end 
		if(outA == 3'b110 || outB == 3'b110)
		begin
			SS <= 1;
			ES <= 8'hFF;
			MS <= 23'd1;
		end 
		
		
		
		// Normal/Subnormal 
		if(outA[0] && outB[0]) 
		begin 
			SS <= 1'bz;
			ES <= 8'bz;
			MS <= 23'bz;
		end
		
		S[31] = SS;
		S[30:23] = ES;
		S[22:0] = MS;
		
	end

endmodule 