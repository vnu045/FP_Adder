module comp_exp(
    input  wire [36:0] NA, NB,
    output reg        SA, SB, Comp,
    output reg [7:0]  Emax,
    output reg [27:0] Mmax, Mshift,
    output reg [4:0]  Dexp
);

// Internal signals
reg [7:0] EA, EB;
reg [27:0] MA, MB;
reg [7:0] dif;
reg C;

always @(*) begin 
    SA = NA[36];
    SB = NB[36];
    EA = NA[35:28];
    EB = NB[35:28];
    MA = NA[27:0];
    MB = NB[27:0];
    
    // Fix mixed assignment: make all blocking (=)
    if (((EA > EB) || (MB[0] == 1'b1)) || (MA >= MB)) 
        C = 1'b1;
    else if ((EA < EB) || (MA < MB)) 
        C = 1'b0;
    else 
        C = 1'bz;

    Comp = C; // Blocking =

    if (C == 1'b1) begin
        Emax = EA;
        Mshift = MB;
        Mmax = MA;
    end 
    else if (C == 1'b0) begin
        Emax = EB;
        Mshift = MA;
        Mmax = MB;
    end 
    else begin
        Emax = 8'bz;
        Mshift = 28'bz;
        Mmax = 28'bz;
    end

    if ((C == 1'b1) && (MB[0] == 1'b0)) 
        dif = EA - EB;
    else if (C == 1'b0) 
        dif = EB - EA;
    else if ((C == 1'b1) && (MB[0] == 1'b1)) 
        dif = EA + EB;
    else 
        dif = 8'bz;

    if (dif == 8'h1B) 
        Dexp = dif[4:0];
    else if (dif > 8'h1B) 
        Dexp = 5'b11100;
    else 
        Dexp = 5'bz;
end

endmodule
