module processor_tb_1;

	reg [23:0] func;
	reg new_func, clk, start, reset;

	reg [5:0] counter;
	
	processor processor_test(.func(func), .new_func(new_func), .clk(clk), .mem_enable(1'b0), .start(start), .reset(reset));
	
	
	initial begin
		clk = 1'b0;
		new_func = 1'b0;
		counter = 5'b00000;
		start = 1'b0;
		reset = 1'b1;
	end
	
	always begin
		#25
		clk = ~clk;
	end
	
	always begin
		#50
		counter = counter + 5'b00001;
	end
	
	reg[15:0] pad_16 = 16'h0000;
	reg[11:0] pad_12 = 12'h000;
	reg[15:0] data_1 = 16'h0010;
	reg[15:0] data_2 = 16'h0004;
	
	always @(counter) begin
	case (counter) 
		
		// 6'b000000: begin 
		// 	start = 1'b1;
		// 	reset = 1'b0;
		// 	new_func = 1'b1;
		// 	func = {4'h0, 4'h0, pad_16};  // reset state
		// end

		// 6'b000001: begin 
		// 	start = 1'b1;
		// 	reset = 1'b0;
		// 	new_func = 1'b0; //wait
		// 	func = {4'h0, 4'h0, pad_16};  // reset state
		// end

		// 6'b000010: begin 
		// 	start = 1'b1;
		// 	reset = 1'b0;
		// 	new_func = 1'b0; //decode
		// 	func = {4'h0, 4'h0, pad_16};  // reset state
		// end

		6'b000011: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h0, 4'h0, data_1};  // load r0 0010
		end

		6'b000100: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h0, 4'h0, data_1};  // load r0 0010
		end

		6'b000101: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h0, 4'h0, data_1};  // load r0 0010
		end

		6'b000110: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h1, 4'h2, 4'h0, pad_12};  // mov r2 r0
		end

		6'b000111: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h1, 4'h2, 4'h0, pad_12};  // mov r2 r0
		end
		
		6'b001000: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h1, 4'h2, 4'h0, pad_12};  // mov r2 r0
		end

		6'b001001: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h0, 4'h1, data_2};  //load r1 0004
		end

		6'b001010: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h0, 4'h1, data_2};  //load r1 0004
		end
		
		6'b001011: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h0, 4'h1, data_2};  //load r1 0004
		end

		6'b001100: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b001101: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b001110: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //add1
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b001111: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //add2
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b010000: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b010001: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h3, 4'h2, 4'h0, pad_12};  //xor r2 r0
		end

		6'b010010: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h3, 4'h2, 4'h0, pad_12};  //xor r2 r0
		end

		6'b010011: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //xor1
			func = {4'h3, 4'h2, 4'h0, pad_12};  //xor r2 r0
		end

		6'b010100: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //xor2
			func = {4'h3, 4'h2, 4'h0, pad_12};  //xor r2 r0
		end

		6'b010101: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h3, 4'h2, 4'h0, pad_12};  //xor r2 r0
		end

		6'b010110: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h4, 4'h0, 4'h2, pad_12};  //min r0 r2
		end

		6'b010111: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h4, 4'h0, 4'h2, pad_12};  //min r0 r2
		end
		
		6'b011000: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //min1
			func = {4'h4, 4'h0, 4'h2, pad_12};  //min r0 r2
		end

		6'b011001: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //min2
			func = {4'h4, 4'h0, 4'h2, pad_12};  //min r0 r2
		end

		6'b011010: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h4, 4'h0, 4'h2, pad_12};  //min r0 r2
		end

		6'b011011: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h5, 4'h5, pad_16}; // ldpc r5
		end

		6'b011100: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h5, 4'h5, pad_16}; // ldpc r5
		end

		6'b011101: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h5, 4'h5, pad_16}; // ldpc r5
		end

		6'b011110: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b011111: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b100000: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //add1
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b100001: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //add2
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b100010: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h2, 4'h0, 4'h1, pad_12};  //add r0 r1
		end

		6'b100011: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h2, 4'h2, 4'h0, pad_12};  //add r2 r0
		end

		6'b100100: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h2, 4'h2, 4'h0, pad_12};  //add r2 r0
		end

		6'b100101: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //add1
			func = {4'h2, 4'h2, 4'h0, pad_12};  //add r2 r0
		end

		6'b100110: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //add2
			func = {4'h2, 4'h2, 4'h0, pad_12};  //add r2 r0
		end

		6'b100111: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h2, 4'h2, 4'h0, pad_12};  //add r2 r0
		end

		6'b101000: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b1; //wait
			func = {4'h6, 4'h5, pad_16}; // branch r5
		end

		6'b101001: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //decode
			func = {4'h6, 4'h5, pad_16}; // branch r5
		end
		
		6'b101010: begin 
			start = 1'b1;
			reset = 1'b0;
			new_func = 1'b0; //done
			func = {4'h6, 4'h5, pad_16}; // branch r5
		end
		
		endcase
	end

initial begin
$dumpfile("processor_tb_1.vcd");
$dumpvars(0, processor_tb_1);
#5000
$finish;
end


endmodule