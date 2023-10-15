module file_reg(D, clk, reset, enable, Q);
  input [15:0] D;
  input clk, reset, enable;
  output reg [15:0] Q;

  always @(posedge clk or posedge reset) begin
      if (reset == 1'b1) begin
          Q <= 16'b0000_0000_0000_0000;
      end else begin
          if (enable == 1'b1) begin
            Q <= D;
          end else begin
            Q <= Q;
          end
      end
  end
endmodule
