module pc(bus, clk, start, rst, pc_enable, branch, address);

    input[15:0] bus;
    input clk, start, rst, pc_enable, branch;
    output reg[15:0] address;

    always @(posedge clk or posedge rst) begin

        if (rst == 1'b1) begin
            address <= 16'b000_0000_0000_0000;

        end else if (start == 1'b1) begin
            address <= 16'b000_0000_0000_0001; 

        end else if (pc_enable == 1'b1) begin
            address <= address + 16'b000_0000_0000_0001;
            
        end else if (branch == 1'b1) begin
            address <= bus; //address stored in register will be written onto databus
        end

    end


endmodule