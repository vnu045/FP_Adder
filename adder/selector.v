module selector(NumA, NumB, EN, EData, NA, NB);

input [31:0] NumA, NumB;
input EN;
output reg [1:0] EData;
output reg [36:0] NA, NB;

wire SA, SB;
wire [7:0] EA, EB;
wire [22:0] MA, MB;

assign SA = NumA[31];
assign SB = NumB[31];
assign EA = NumA[30:23];
assign EB = NumB[30:23];
assign MA = NumA[22:0];
assign MB = NumB[22:0];

always @(*)
begin
	if(EN == 1) 
	begin 
	NA[36] <= SA;
	NA[35:28] <= EA;
	NB[36] <= SB;
	NB[35:28] <= EB;
	
		if(EA > 8'h00)
		begin 
		NA[27] <= 1;
		NA[26:4] <= MA;
		NA[3:0] <= 4'h0;
		end 
		else if(EA == 8'h0)
		begin
		NA[27] <= 0;
		NA[26:4] <= MA;
		NA[3:0] <= 4'h0;
		end 
		else NA <= 28'bz;
		
		
		if(EB > 8'h0)
		begin 
		NB[27] <= 1;
		NB[26:4] <= MB;
		NB[3:0] <= 4'h0;
		end 
		else if(EB == 8'h0)
		begin
		NB[27] <= 0;
		NB[26:4] <= MB;
		NB[3:0] <= 4'h0;
		end 
		else NB <= 28'bz;
	end 
	else
	begin 
	NA <= 28'bz;
	NB <= 28'bz;
	end
	
	if(EA == 8'd0 && EB == 8'd0 && EN == 1) EData <= 2'b00;
	else if(EA > 8'd0 && EB > 8'd0 && EN == 1) EData <= 2'b01;
	else if((EA == 8'd0 || EB == 8'd0) && EN == 1) EData <= 2'b10;
	else EData <= 2'bz;
end
endmodule 