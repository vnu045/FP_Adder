module reg_case (
    input  wire        clk,
    input  wire        reset,    // Active high synchronous reset
    input  wire [31:0] A_in,
    input  wire [31:0] B_in,
    input  wire        A_S_in,
    output reg  [31:0] A_out,
    output reg  [31:0] B_out,
    output reg         A_S_out
);

    always @(posedge clk) begin
        if (!reset) begin
            A_out <= 32'd0;
            B_out <= 32'd0;
            A_S_out     <= 1'b0;
        end else begin
            A_out <= A_in;
            B_out <= B_in;
            A_S_out     <= A_S_in;
        end
    end

endmodule
