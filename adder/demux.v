module demux(NA, NB, EData, NA0, NB0, NA1, NB1, NA2, NB2);

input [36:0] NA, NB;
input [1:0] EData;
output reg [36:0] NA0, NB0, NA1, NB1, NA2, NB2;

	always @(*) 
	begin 
		case(EData)
		2'b00: 
			begin
			NA0 = NA;
			NB0 = NB;
			NA1 = 37'bz;
			NB1 = 37'bz;
			NA2 = 37'bz;
			NB2 = 37'bz;
			end
		2'b01:
			begin
			NA0 = 37'bz;
			NB0 = 37'bz;
			NA1 = NA;
			NB1 = NB;
			NA2 = 37'bz;
			NB2 = 37'bz;
			end
		2'b10:
			begin
			NA0 = 37'bz;
			NB0 = 37'bz;
			NA1 = 37'bz;
			NB1 = 37'bz;
			NA2 = NA;
			NB2 = NB;
			end
		default:
			begin
			NA0 = 37'bz;
			NB0 = 37'bz;
			NA1 = 37'bz;
			NB1 = 37'bz;
			NA2 = 37'bz;
			NB2 = 37'bz;
			end
		endcase 
	end 
endmodule 
