module reg_adder (
    input  wire        clk,
    input  wire        reset,
    input  wire        A_S_case_in,
    input  wire        SA_in,
    input  wire        SB_in,
    input  wire        C_in,
    input  wire [6:0]  EO_in,
    input  wire [26:0] MAOut_in,
    input  wire [26:0] MBOut_in,
	 input  wire [31:0] S_in,
	 input  wire 		  EN_in,
    output reg         A_S_case_out,
    output reg         SA_out,
    output reg         SB_out,
    output reg         C_out,
    output reg [6:0]   EO_out,
    output reg [26:0]  MAOut_out,
    output reg [26:0]  MBOut_out,
	 output reg [31:0]  S_out,
	 output reg 		  EN_out

);

    always @(posedge clk) begin
        if (!reset) begin
            A_S_case_out <= 1'b0;
            SA_out       <= 1'b0;
            SB_out       <= 1'b0;
            C_out        <= 1'b0;
            EO_out       <= 7'd0;
            MAOut_out    <= 27'd0;
            MBOut_out    <= 27'd0;
				S_out			 <= 31'd0;
				EN_out		 <= 1'b0;
        end else begin
            A_S_case_out <= A_S_case_in;
            SA_out       <= SA_in;
            SB_out       <= SB_in;
            C_out        <= C_in;
            EO_out       <= EO_in;
            MAOut_out    <= MAOut_in;
            MBOut_out    <= MBOut_in;
				S_out			 <= S_in;
				EN_out		 <= EN_in;
        end
    end

endmodule
