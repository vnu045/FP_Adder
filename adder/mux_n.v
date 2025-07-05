module mux_n (A, B, Sel, Z);

input A, B, Sel;
output reg Z;

always @(*)
begin 
	if (Sel == 1) Z <= A;
	else Z <= B;
end 
endmodule 