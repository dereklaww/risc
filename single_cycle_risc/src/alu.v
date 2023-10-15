module alu(ins, a_in, b_in, alu_out);

    input[3:0] ins;
    input[15:0] a_in, b_in;
    output reg[15:0] alu_out;

    // 0010: ADD
	// 0011: XOR
    // 0100: MIN
    // 0111: MINALL

    always @(ins, a_in, b_in) begin
        
        case(ins)

        4'b0010 : begin alu_out <= a_in + b_in; end //ADD
        4'b0011 : begin alu_out <= a_in ^ b_in; end //XOR
        4'b0100 : begin //MIN
            if (a_in > b_in) begin
                alu_out <= b_in;
            end else begin
                alu_out <= a_in;
            end
        end
        4'b0111 : begin //MINALL
            if (a_in > b_in) begin
                alu_out <= b_in;
            end else begin
                alu_out <= a_in;
            end
        end
        endcase
        

    end

endmodule



	