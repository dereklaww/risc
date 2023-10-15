module rom(addr, func_out, clk);
	input [15:0] addr;
	input clk;
	output reg [23:0] func_out;

	reg[23:0] mem [128:0];

	reg[15:0] low_16 = 16'h0000;
	reg[11:0] low_12 = 12'h000;
	reg[15:0] data_1 = 16'h0010;
	reg[15:0] data_2 = 16'h0004;

	always @(posedge clk) begin
		// to test basic functions - comment this block and uncomment MINALL block
		mem[0] <= {4'h0, 4'h0, low_16};  // reset state

		mem[1] <= {4'h0, 4'h0, data_1};  // load r0 0010
		mem[2] <= {4'h1, 4'h2, 4'h0, low_12};  // mov r2 r0
		mem[3] <= {4'h0, 4'h1, data_2};  //load r1 0004
		// r0 - h'10
		// r1 - h'04
		// r2 - h'10
		mem[4] <= {4'h2, 4'h0, 4'h1, low_12};  //add r0 r1
		// r0 - h'14
		mem[5] <= {4'h3, 4'h2, 4'h0, low_12};  //xor r2 r0
		// r2 - h'4
		mem[6] <= {4'h4, 4'h0, 4'h2, low_12};  //min r0 r2
		// r0 - h'4
		mem[7] <= {4'h5, 4'h5, low_16}; // ldpc r5
		mem[8] <= {4'h2, 4'h0, 4'h1, low_12};  //add r0 r1
		mem[9] <= {4'h2, 4'h2, 4'h0, low_12};  //add r2 r0
		mem[10] <= {4'h6, 4'h5, low_16}; // branch r5

		//to test minALL - uncomment this block and comment the above one
		// mem[0] <= {4'h0, 4'h0, low_16}; // reset
		// mem[1] <= {4'h0, 4'h0, 16'h1111}; //load r0 1111
		// mem[2] <= {4'h0, 4'h1, 16'h1110}; //load r1 1110
		// mem[3] <= {4'h0, 4'h2, 16'h1100}; //load r2 1100
		// mem[4] <= {4'h0, 4'h3, 16'h1001}; //load r3 1001
		// mem[5] <= {4'h0, 4'h4, 16'h1000}; //load r4 1000
		// mem[6] <= {4'h0, 4'h5, 16'h0000}; //load r5 0000
		// mem[7] <= {4'h0, 4'h6, 16'h0011}; //load r6 0011
		// mem[8] <= {4'h0, 4'h7, 16'h1000}; //load r7 1000
		// mem[9] <= {4'h0, 4'h8, 16'h1100}; //load r8 1100
		// mem[10] <= {4'h0, 4'h9, 16'h1111}; //load r9 1111
		// mem[11] <= {4'h0, 4'hA, 16'h1111}; //load r10 1111
		// mem[12] <= {4'h0, 4'hB, 16'h1111}; //load r11 1111
		// mem[13] <= {4'h0, 4'hC, 16'h1111}; //load r12 1111
		// mem[14] <= {4'h0, 4'hD, 16'h1111}; //load r13 1111
		// mem[15] <= {4'h0, 4'hE, 16'h1111}; //load r14 1111
		// mem[16] <= {4'h0, 4'hF, 16'h1111}; //load r15 1111
		// mem[17] <= {4'h7, 4'h0, low_16}; //minall

		func_out <= mem[addr];
	end

endmodule