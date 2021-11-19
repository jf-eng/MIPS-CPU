module datapath(
	input logic clk,
	input logic RegDst, MemtoReg,
	input logic[4:0] rs, rt, rd,
	input logic[15:0] alu_immediate,
	input logic jump, addiu, addu, lw, sw,
	output logic[31:0] data_address, data_writedata,
	input logic[31:0] data_readdata,
	output logic data_read, data_write
);

	// REGFILE INPUTS
	logic clk, wen, reset;
	logic[31:0] write_data;
	logic[4:0] write_addr;
	logic[4:0] read_addr_0, read_addr_1;

	// REGFILE OUTPUTS
	logic[31:0] read_data_0, read_data_1;

	assign read_addr_0 = rs;
	assign read_addr_1 = rt;
	assign write_addr = (RegDst) ? rd : rt;


	//REGFILE
	regfile regfile_0(
		.clk(clk), .wen(wen), .reset(reset),
		.write_data(write_data), .write_addr(write_addr),
		.read_addr_0(read_addr_0), .read_addr_1(read_addr_1),
		.read_data_0(read_data_0), .read_data_1(read_data_1)
	);

	logic [31:0] sign_extended;
	assign sign_extended = (alu_immediate[15]) ? {16'hffff, alu_immediate} : {16'h0000, alu_immediate};

	//ALU
	logic add;
	logic[31:0] alu_out;
	assign add = (addiu || addu) ? 1 : 0;
	logic[31:0] op2;
	assign op2 = ALUSrc ? read_data_1 : sign_extended;
	alu alu_0(
		.op1(rs),
		.op2(op2),
		.add(add),
		.alu_out(alu_out)
	);

	// WRAP AROUND RAM
	assign data_address = alu_out;
	assign data_writedata = read_data_1;
	
	assign write_data = (MemtoReg) ? data_readdata : alu_out;  



	
endmodule