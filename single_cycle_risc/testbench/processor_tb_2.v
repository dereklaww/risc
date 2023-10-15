module processor_tb_2();
	// this tests if the processor could read from memory
	  reg [23:0] func;
	  reg new_func, clk, mem_enable, start, reset;
	  reg [12:0] counter;
	  
	  processor inst_processor_test(.func(func), .new_func(new_func), .clk(clk), .mem_enable(1'b1),
	   .start(start), .reset(reset));
	  
	  initial begin
		 clk = 1'b0;
		 start = 1'b0;
		 reset = 1'b0;
		 counter = 12'h000;
	  end
	  
	  always begin
		 #25
		 clk = ~clk;
	  end

	  always begin

		  #50
		  counter = counter + 12'h001;
	  end
		
		always @(counter) begin
			case(counter)

				6'b000000: begin reset = 1'b1; start = 1'b0; end //reset
				6'b000001: begin reset = 1'b0; start = 1'b1; end //start
				default: begin reset = 1'b0; start = 1'b0; end //program started, will continue to run

			endcase
		end


    initial begin
        $dumpfile("processor_tb_2.vcd");
        $dumpvars(0, processor_tb_2);
        #5000
        $finish;
    end
endmodule