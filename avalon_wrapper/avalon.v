module avalon
(
input clk,
input reset_n,
input chipselect,
input read,
input write,
input [3:0] address,
input [31:0] writedata,
output [31:0] readdata
);

reg [31:0] a, b;
wire [31:0] z;

fpadder1 add0(.clk(clk), .rst(reset_n), .NumberA(a), .NumberB(b), .Result(z));

reg [31:0] read_data_reg;
assign readdata = read_data_reg;
always@(posedge clk or negedge reset_n) 
begin
	if (!reset_n) begin 
		a <=31'd0;
		b <=31'd0;
		read_data_reg <=31'd0;
	end else begin
		if (chipselect & write) begin
                case (address)
                    4'd0: a <= writedata[31:0];
                    4'd1: b <= writedata[31:0];
                endcase
            end

            if (chipselect & read) begin
                case (address)
                    4'd2: read_data_reg <= z; 
                endcase 
				end 
		end 
end 
endmodule 