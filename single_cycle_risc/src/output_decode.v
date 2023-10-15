module output_decode(state, func, reg_sig, tri_sig, branch, pc_enable, count);

input[4:0] state;
input[23:0]func;
//[ins(4 bits [23:20])][op1(4bits) [19:16]][op2(4bits) [15:12]][padding(12bits)] OR
//[ins(4 bits)][op1(4bits)][data(16bits)]

output [18:0] reg_sig;
//[reg 0-15][G reg][A reg]
output [18:0] tri_sig;
//[tri 0-15][G tri][load tri][PC tri]
output reg branch, pc_enable;

reg [4:0] reg_in, tri_out;

sig_decoder reg_decode(reg_in, reg_sig);
sig_decoder tri_decode(tri_out, tri_sig);

output reg [3:0] count;

initial begin
    count <= 1'b0;
end

always @(state) begin 

    case(state) 
    
    //ALU
    5'b00011: 
        begin
            reg_in <= {1'b1, 4'h1}; //a_in
            tri_out <= {1'b0, func[19:16]}; //op1 reg
        end
    
    5'b00100:
        begin
            reg_in <= {1'b1, 4'h0}; //g_in
            tri_out <= {1'b0, func[15:12]}; //op2 reg
        end

    5'b00101:
        begin
            reg_in <= {1'b0, func[19:16]}; //op1 reg
            tri_out <= {1'b1, 4'h0}; //g_out
        end

    //LOAD
    5'b00110:
        
        begin
            reg_in <= {1'b0, func[19:16]}; //op1 reg
            tri_out <= {1'b1, 4'h1}; //load tri
        end

    // MOVE
    5'b00111:
        begin
            reg_in <= {1'b0, func[19:16]}; //op1 reg
            tri_out <= {1'b0, func[15:12]}; //op2 reg
        end

    //LDPC
    5'b01000:
        begin
            reg_in <= {1'b0, func[19:16]}; //op1 reg
            tri_out <= {1'b1, 4'h2}; //pc tri buf
        end

    //BRANCH
    5'b01001: 
        begin
            reg_in <= {1'b1, 4'hA}; //unknown reg - no writing required for reg
            tri_out <= {1'b0, func[19:16]}; //op1 reg
        end

    //MINALL
    5'b01010: 
        begin
            reg_in <= {1'b1, 4'h1}; //A reg
            tri_out <= {1'b0, 4'h0}; //r0
            count <= 4'h1; //initial count = 1
        end

    5'b01011: 
        begin
            reg_in <= {1'b1, 4'h0}; //G reg
            tri_out <= {1'b0, count}; //r-count
        end

    5'b01100: 
        begin
            reg_in <= {1'b1, 4'h1}; //A reg
            tri_out <= {1'b1, 4'h0}; //G reg
            count <= count + 4'h1;
        end

    5'b01101: 
        begin
            reg_in <= {1'b0, 4'h0}; //r0 
            tri_out <= {1'b1, 4'h1}; //A reg
        end

    default: begin reg_in <= {1'b1, 4'hA}; tri_out <= {1'b1, 4'hA}; end //unknown reg/tribuf - will decode as 0

    endcase

end

always @(state) begin 

    if (state == 5'b01001) begin
        branch <= 1'b1;
    end else begin 
        branch <= 1'b0;
    end

end

always @(state) begin 

    case (state)

    5'b00101: begin pc_enable <= 1'b1; end //alu
    5'b00110: begin pc_enable <= 1'b1; end //load
    5'b00111: begin pc_enable <= 1'b1; end //move
    5'b01000: begin pc_enable <= 1'b1; end //ldpc
    5'b01101: begin pc_enable <= 1'b1; end //minall
    default: begin pc_enable <= 1'b0; end
    endcase

end


endmodule

module sig_decoder(index_in, sig_out);

input[4:0] index_in;
// converts reg/tri buf index above into an array of reg /tribuf enable signals
// 1 signifies enable, otherwise 0
output reg[18:0] sig_out;

always @(index_in) begin
    case (index_in)

    5'b00000: begin sig_out <= 19'b000_0000_0000_0000_0001; end
    5'b00001: begin sig_out <= 19'b000_0000_0000_0000_0010; end
    5'b00010: begin sig_out <= 19'b000_0000_0000_0000_0100; end
    5'b00011: begin sig_out <= 19'b000_0000_0000_0000_1000; end

    5'b00100: begin sig_out <= 19'b000_0000_0000_0001_0000; end
    5'b00101: begin sig_out <= 19'b000_0000_0000_0010_0000; end
    5'b00110: begin sig_out <= 19'b000_0000_0000_0100_0000; end
    5'b00111: begin sig_out <= 19'b000_0000_0000_1000_0000; end

    5'b01000: begin sig_out <= 19'b000_0000_0001_0000_0000; end
    5'b01001: begin sig_out <= 19'b000_0000_0010_0000_0000; end
    5'b01010: begin sig_out <= 19'b000_0000_0100_0000_0000; end
    5'b01011: begin sig_out <= 19'b000_0000_1000_0000_0000; end

    5'b01100: begin sig_out <= 19'b000_0001_0000_0000_0000; end
    5'b01101: begin sig_out <= 19'b000_0010_0000_0000_0000; end
    5'b01110: begin sig_out <= 19'b000_0100_0000_0000_0000; end
    5'b01111: begin sig_out <= 19'b000_1000_0000_0000_0000; end

    5'b10000: begin sig_out <= 19'b001_0000_0000_0000_0000; end //G reg/G tri
    5'b10001: begin sig_out <= 19'b010_0000_0000_0000_0000; end //A reg/load tri
    5'b10010: begin sig_out <= 19'b100_0000_0000_0000_0000; end //PC tri

    default: begin sig_out <= 19'b000_0000_0000_0000_0000; end
    endcase
end

endmodule