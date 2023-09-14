module tri_buf (a,b,enable);
  input[15:0] a;
  output reg[15:0] b;
  input enable;

  always @(enable) begin
    if(enable) begin
      b <= a;
    end else begin
      b <= 16'bzzzz_zzzz_zzzz_zzzz;
    end
  end
endmodule
