module regfile (
	input logic clk, wen, reset,
	input logic[31:0] write_data,
	input logic[4:0] write_addr,
	input logic[4:0] read_addr_0, read_addr_1,
	output logic[31:0] read_data_0, read_data_1,
	output logic[31:0] register_v0
);

	reg [31:0] regs [0:31];

	assign register_v0 = regs[2];

	logic [31:0] reg0,  reg1,  reg2,   reg3,  reg4,  reg5,  reg6,  reg7;
	logic [31:0] reg8,  reg9,  reg10, reg11, reg12, reg13, reg14, reg15;
	logic [31:0] reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23;
	logic [31:0] reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;

	always_ff @(posedge clk) begin
		if(reset == 1) begin
			for(integer i = 0; i < 32; i=i+1) begin
				regs[i] <= 0;
			end
		end
		if(wen == 1) begin
			regs[write_addr] <= (write_addr == 0) ? 0 : write_data;
		end
	end

	always_comb begin
		read_data_0 = (read_addr_0 == 0) ? 0 : regs[read_addr_0];
		read_data_1 = (read_addr_1 == 0) ? 0 : regs[read_addr_1];
	end

endmodule