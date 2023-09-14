module find_ns(curr_state, next_state, ins, new_ins, reset, count);
input [4:0] curr_state;
input [3:0] ins;

// 0000: LOAD
// 0001: MOV
// 0010: ADD
// 0011: XOR
// 0100: MIN
// 0101: LDPC
// 0110: BRANCH
// 0111: MINALL

//signals new instruction
input new_ins, reset;
output reg[4:0] next_state;

//counter for MINALL
input[3:0] count;

always @(curr_state, ins, new_ins, reset) begin

	if (reset == 1'b1) begin
		next_state <= 5'b00000;
	end else begin 

		case(curr_state)
			// reset 
			5'b00000: begin next_state <= 5'b00001; end
				
			// wait
			5'b00001: begin
				if (new_ins == 1'b1) begin
					next_state <= 5'b00010;
				end
			end
				
			// decode state
			5'b00010: begin
				case (ins)
					4'b0000: next_state <= 5'b00110; //LOAD
					4'b0001: next_state <= 5'b00111; //MOV
					4'b0010: next_state <= 5'b00011; //ADD
					4'b0011: next_state <= 5'b00011; //XOR
					4'b0100: next_state <= 5'b00011; //MIN
					4'b0101: next_state <= 5'b01000; //LDPC
					4'b0110: next_state <= 5'b01001; //BRANCH
					4'b0111: next_state <= 5'b01010; //MINALL
					default: next_state <= 5'b00001; //wait

				endcase
			end
			
			// ALU - ADD or XOR or MIN
			5'b00011: begin next_state <= 5'b00100; end
			5'b00100: begin next_state <= 5'b00101; end
			5'b00101: begin next_state <= 5'b00001; end // go back to 'wait' state
			
			// LOAD
			5'b00110: begin next_state <= 5'b00001; end
			
			// MOVE
			5'b00111: begin next_state <= 5'b00001; end

			//LDPC
			5'b01000: begin next_state <= 5'b00001; end

			//BRANCH
			5'b01001: begin next_state <= 5'b00001; end

			//MINALL
			5'b01010: begin next_state <= 5'b01011; end
			5'b01011: begin next_state <= 5'b01100; end
			5'b01100: begin 
					if (count < 4'hF) begin
						next_state <= 5'b1011;
					end else if (count == 4'hF) begin
						next_state <= 5'b1101;
					end
				end
			5'b01101: begin next_state <= 5'b00001; end
			
			default: begin next_state <= 5'b00000; end //reset
		endcase
end
end
endmodule
