module comp (
    input  wire [36:0] NumberA,  // Number A
    input  wire [36:0] NumberB,  // Number B
    output reg  [36:0] NA,       // Normal number
    output reg  [36:0] NB        // Subnormal number
);

    // Internal wires
    wire [7:0] EA = NumberA[35:28];  // Exponent of A
    wire [7:0] EB = NumberB[35:28];  // Exponent of B

    always @(*) begin
        if (EA == 8'h00) begin
            // Number A is subnormal
            NB = NumberA;
            NA = NumberB;
        end else if (EB == 8'h00) begin
            // Number B is subnormal
            NB = NumberB;
            NA = NumberA;
        end else begin
            // None is subnormal (could be handled accordingly)
            NB = 37'dz;  // Placeholder
            NA = 37'dz;  // Placeholder
        end
    end

endmodule
