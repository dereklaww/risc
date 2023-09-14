module state_reg(D, clk, rst, Q);
    input [4:0] D;
    input clk, rst;
    output reg [4:0] Q;
  
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)
            Q <= 5'b00000;
        else
            Q <= D;
    end
endmodule