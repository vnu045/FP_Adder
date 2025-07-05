module round (
    input wire [27:0] Min,   // Input's mantissa
    output reg [22:0] Mout  // Output's mantissa
);

always @(*) begin
    if (Min[3:0] === 'bz) // Undefined case
        Mout <= 23'b0; // Default to zero
    else if (Min[3:0] >= 4'b1000) // Round Mantissa
        Mout <= Min[26:4] + 1;
    else
        Mout <= Min[26:4];
end

endmodule
