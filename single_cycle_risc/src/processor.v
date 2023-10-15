module processor(func, new_func, clk, mem_enable, start, reset);

//processor inputs
input [23:0] func;
input clk, new_func, start, reset;
input mem_enable;

// control signals
wire pc_enable, branch;

wire [15:0] addr;
wire [23:0] mem_out;
wire [15:0] bus;

reg [23:0] func_in;
reg new_ins;
wire[18:0] reg_sig, tri_sig;

always @(mem_enable, func, mem_out, new_func) begin
    if(mem_enable) begin
        func_in = mem_out;
        new_ins = 1'b1;
    end
    else begin //to test manually entered functions bypassing the rom
        func_in = func;
        new_ins = new_func;
    end
end

control control_unit(.func(func_in), .clk(clk), .new_ins(new_ins), .reg_sig(reg_sig), .tri_sig(tri_sig), .branch(branch), .pc_enable(pc_enable));

datapath datapath_inst(.clk(clk), .reset(reset), .func(func_in), .address(addr), .reg_sig(reg_sig), .tri_sig(tri_sig), .bus(bus));

pc inst_pc(.bus(bus), .clk(clk), .start(start), .rst(reset), .pc_enable(pc_enable), .branch(branch), .address(addr));

rom rom_inst(.addr(addr), .func_out(mem_out), .clk(clk));

endmodule