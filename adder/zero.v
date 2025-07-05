module zero (
    input  wire [27:0] T,        // Significand
    output wire [4:0]  Zcount    // Number of Zeros
);

    // Internal signals
    wire [27:0] Zero_vector;
    reg  [7:0] aux;

    assign Zero_vector = 28'h0000000; // 28-bit all zero

    always @(*) begin
        if (T[27:27] == 1'b0)
            aux = 8'h00;
        else if (T == Zero_vector)
            aux = 8'h1C;
        else if (T[27:1] == Zero_vector[27:1])
            aux = 8'h1B;
        else if (T[27:2] == Zero_vector[27:2])
            aux = 8'h1A;
        else if (T[27:3] == Zero_vector[27:3])
            aux = 8'h19;
        else if (T[27:4] == Zero_vector[27:4])
            aux = 8'h18;
        else if (T[27:5] == Zero_vector[27:5])
            aux = 8'h17;
        else if (T[27:6] == Zero_vector[27:6])
            aux = 8'h16;
        else if (T[27:7] == Zero_vector[27:7])
            aux = 8'h15;
        else if (T[27:8] == Zero_vector[27:8])
            aux = 8'h14;
        else if (T[27:9] == Zero_vector[27:9])
            aux = 8'h13;
        else if (T[27:10] == Zero_vector[27:10])
            aux = 8'h12;
        else if (T[27:11] == Zero_vector[27:11])
            aux = 8'h11;
        else if (T[27:12] == Zero_vector[27:12])
            aux = 8'h10;
        else if (T[27:13] == Zero_vector[27:13])
            aux = 8'h0F;
        else if (T[27:14] == Zero_vector[27:14])
            aux = 8'h0E;
        else if (T[27:15] == Zero_vector[27:15])
            aux = 8'h0D;
        else if (T[27:16] == Zero_vector[27:16])
            aux = 8'h0C;
        else if (T[27:17] == Zero_vector[27:17])
            aux = 8'h0B;
        else if (T[27:18] == Zero_vector[27:18])
            aux = 8'h0A;
        else if (T[27:19] == Zero_vector[27:19])
            aux = 8'h09;
        else if (T[27:20] == Zero_vector[27:20])
            aux = 8'h08;
        else if (T[27:21] == Zero_vector[27:21])
            aux = 8'h07;
        else if (T[27:22] == Zero_vector[27:22])
            aux = 8'h06;
        else if (T[27:23] == Zero_vector[27:23])
            aux = 8'h05;
        else if (T[27:24] == Zero_vector[27:24])
            aux = 8'h04;
        else if (T[27:25] == Zero_vector[27:25])
            aux = 8'h03;
        else if (T[27:26] == Zero_vector[27:26])
            aux = 8'h02;
        else if (T[27:27] == Zero_vector[27:27])
            aux = 8'h01;
        else
            aux = 8'h00;
    end

    assign Zcount = aux[4:0];

endmodule
