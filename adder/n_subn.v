module n_subn (
    input  wire [36:0] NA,  
    input  wire [36:0] NB,  
    output wire        Comp,     
    output wire        SA,       
    output wire        SB,       
    output wire [7:0]  EO,       
    output wire [27:0] MA,      
    output wire [27:0] MB        
);

    
    wire [27:0] MAa, MBb;
    wire        C;

    
    assign SA = NA[36];  // Sign bit of A
    assign SB = NB[36];  // Sign bit of B

    
    assign MAa = NA[27:0];  // Mantissa of A
    assign MBb = NB[27:0];  // Mantissa of B

    // Number comparison: A >= B -> C = 1, else C = 0
    assign C = (MAa >= MBb) ? 1 : ((MBb > MAa) ? 0 : 1'bz);

    // Output comparison
    assign Comp = C;

    // Exponent output from NA
    assign EO = NA[35:28];

    // Select correct mantissas based on comparison
    assign MB = (C == 1) ? MBb : MAa;  // Replace 28'b0 with proper logic if needed
    assign MA = (C == 1) ? MAa : MBb;   // Replace logic if needed

endmodule
