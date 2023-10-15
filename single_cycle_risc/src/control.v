module control(func, clk, new_ins, reg_sig, tri_sig, branch, pc_enable);

input[23:0] func;
//[ins(4 bits [23:20])][op1(4bits) [19:16]][op2(4bits) [15:12]][padding(12bits)] OR
//[ins(4 bits)][op1(4bits)][data(16bits)]

// 0000: LOAD
// 0001: MOV
// 0010: ADD
// 0011: XOR
// 0100: MIN
// 0101: LDPC
// 0110: BRANCH
// 0111: MINALL

input clk, new_ins;
output [18:0] reg_sig, tri_sig;
output pc_enable, branch;

wire [4:0] curr_state, next_state;
wire [3:0] count;

find_ns inst_ns(.curr_state(curr_state), .next_state(next_state), .ins(func[23:20]), .new_ins(new_ins), .reset(reset), .count(count));
state_reg inst_state_reg(.D(next_state), .clk(clk), .rst(reset), .Q(curr_state));
output_decode inst_decoder(.state(curr_state), .func(func), .reg_sig(reg_sig), .tri_sig(tri_sig), .branch(branch), .pc_enable(pc_enable), .count(count));

endmodule