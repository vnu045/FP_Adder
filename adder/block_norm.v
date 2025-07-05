module block_norm (
    input  wire [27:0] MS,
    input  wire [7:0]  ES,
    input  wire        Co,
    output wire [22:0] M,
    output reg  [7:0]  E
);

    wire [4:0] Zcount_aux;
    reg  [4:0] Shft;
    wire [27:0] Number;

    // Component declarations
    zero u_zero (
        .T(MS),
        .Zcount(Zcount_aux)
    );

    shift_left u_shift_left (
        .T(MS),
        .Shft(Shft),
        .S(Number)
    );

    round u_round (
        .Min(Number),
        .Mout(M)
    );

    // Logic to determine Shift and E
    always @(*) begin
        if (Zcount_aux == 5'dz) begin
            Shft <= 5'dz;
            E <= 'bz;
        end
        else if (ES > Zcount_aux) begin
            Shft <= Zcount_aux;
            E <= ES - Shft + Co;
        end
        else if (ES < Zcount_aux) begin
            Shft <= ES[4:0];
            E <= 8'd0;
        end
        else begin // ES == Zcount_aux
            Shft <= Zcount_aux;
            E <= 8'd1;
        end
    end

endmodule
