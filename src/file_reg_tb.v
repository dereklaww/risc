module file_reg_tb();

    reg[3:0] counter;
    reg[15:0] a_in;
    reg enable, reset, clk;

    wire[15:0] b_out;


    file_reg inst_reg(.D(a_in), .clk(clk), .reset(reset), .enable(enable), .Q(b_out));


    initial begin
        clk = 1'b0;
        reset = 1'b0;
        counter = 4'h1;
    end
	  
	  always begin
		 #25
		 clk = ~clk;
	  end

	  always begin

		  #50
		  counter = counter + 4'h1;
	  end
		
		always @(counter) begin
			case(counter)

				4'h1: begin a_in = 16'h0001; reset = 1'b1; enable = 1'b0; end
                4'h2: begin a_in = 16'h0001; reset = 1'b0; enable = 1'b1; end
                4'h3: begin a_in = 16'h0002; reset = 1'b0; enable = 1'b1; end

			endcase
		end


    initial begin
        $dumpfile("file_reg_tb.vcd");
        $dumpvars(0, file_reg_tb);
        #3000
        $finish;
    end

endmodule