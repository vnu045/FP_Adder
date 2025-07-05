module reg_vector (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] Ncase_in,
    input  wire        SS_in,
    input  wire [27:0] MS_in,
    input  wire [6:0]  EO_in,
    input  wire        Co_in,
    input  wire        EN_in,
    output reg  [31:0] Ncase_out,
    output reg         SS_out,
    output reg [27:0]  MS_out,
    output reg [6:0]   EO_out,
    output reg         Co_out,
    output reg         EN_out
);

    always @(posedge clk) begin
        if (!reset) begin
            Ncase_out <= 32'd0;
            SS_out    <= 1'b0;
            MS_out    <= 28'd0;
            EO_out    <= 7'd0;
            Co_out    <= 1'b0;
            EN_out    <= 1'b0;
        end else begin
            Ncase_out <= Ncase_in;
            SS_out    <= SS_in;
            MS_out    <= MS_in;
            EO_out    <= EO_in;
            Co_out    <= Co_in;
            EN_out    <= EN_in;
        end
    end

endmodule
