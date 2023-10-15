module datapath(clk, reset, func, address, reg_sig, tri_sig, bus);

input[23:0] func;
input clk, reset; 
input[18:0] reg_sig, tri_sig;
input [15:0] address;

output [15:0] bus;

// file register wire
wire [15:0] reg_out[15:0];
// alu register wire
wire [15:0] ALU_in, ALU_out, G_output, pc_output;


// file registers
file_reg r0(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[0]), .Q(reg_out[0]));
file_reg r1(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[1]), .Q(reg_out[1]));
file_reg r2(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[2]), .Q(reg_out[2]));
file_reg r3(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[3]), .Q(reg_out[3]));
file_reg r4(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[4]), .Q(reg_out[4]));
file_reg r5(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[5]), .Q(reg_out[5]));
file_reg r6(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[6]), .Q(reg_out[6]));
file_reg r7(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[7]), .Q(reg_out[7]));
file_reg r8(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[8]), .Q(reg_out[8]));
file_reg r9(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[9]), .Q(reg_out[9]));
file_reg r10(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[10]), .Q(reg_out[10]));
file_reg r11(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[11]), .Q(reg_out[11]));
file_reg r12(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[12]), .Q(reg_out[12]));
file_reg r13(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[13]), .Q(reg_out[13]));
file_reg r14(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[14]), .Q(reg_out[14]));
file_reg r15(.D(bus), .clk(clk), .reset(reset), .enable(reg_sig[15]), .Q(reg_out[15]));
  
// register tristate buffers
tri_buf t0(.a(reg_out[0]),.b(bus), .enable(tri_sig[0]));
tri_buf t1(.a(reg_out[1]),.b(bus), .enable(tri_sig[1]));
tri_buf t2(.a(reg_out[2]),.b(bus), .enable(tri_sig[2]));
tri_buf t3(.a(reg_out[3]),.b(bus), .enable(tri_sig[3]));
tri_buf t4(.a(reg_out[4]),.b(bus), .enable(tri_sig[4]));
tri_buf t5(.a(reg_out[5]),.b(bus), .enable(tri_sig[5]));
tri_buf t6(.a(reg_out[6]),.b(bus), .enable(tri_sig[6]));
tri_buf t7(.a(reg_out[7]),.b(bus), .enable(tri_sig[7]));
tri_buf t8(.a(reg_out[8]),.b(bus), .enable(tri_sig[8]));
tri_buf t9(.a(reg_out[9]),.b(bus), .enable(tri_sig[9]));
tri_buf t10(.a(reg_out[10]),.b(bus), .enable(tri_sig[10]));
tri_buf t11(.a(reg_out[11]),.b(bus), .enable(tri_sig[11]));
tri_buf t12(.a(reg_out[12]),.b(bus), .enable(tri_sig[12]));
tri_buf t13(.a(reg_out[13]),.b(bus), .enable(tri_sig[13]));
tri_buf t14(.a(reg_out[14]),.b(bus), .enable(tri_sig[14]));
tri_buf t15(.a(reg_out[15]),.b(bus), .enable(tri_sig[15]));

// program counter tristate buf 
tri_buf pc_tri(.a(address), .b(bus), .enable(tri_sig[18]));

// data load tristate buf
tri_buf data_tri(.a(func[15:0]),.b(bus),.enable(tri_sig[17]));

// ALU registers, tristate buf
file_reg A_reg(.D(bus), .clk(clk), .enable(reg_sig[17]),.Q(ALU_in));

file_reg g(.D(ALU_out), .clk(clk), .enable(reg_sig[16]), .Q(G_output));
tri_buf g_tri(.a(G_output), .b(bus), .enable(tri_sig[16]));

alu inst_alu(.ins(func[23:20]), .a_in(ALU_in), .b_in(bus), .alu_out(ALU_out));
  
	

endmodule




