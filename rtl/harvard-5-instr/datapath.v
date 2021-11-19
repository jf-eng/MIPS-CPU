module datapath (
	input logic clk,

	output logic[31:0] rs,
	input logic[31:0] ir,
	input logic[31:0] pc,
	input logic jump, addiu, addu, lw, sw

);

	// REGFILE INPUTS
	logic clk, wen, reset;
	logic[31:0] write_data;
	logic[4:0] write_addr;
	logic[4:0] read_addr_0, read_addr_1;

	// REGFILE OUTPUTS
	logic[31:0] read_data_0, read_data_1;

	//REGFILE
	regfile regfile_0(
		.clk(clk), .wen(wen), .reset(reset),
		.write_data(write_data), .write_addr(write_addr),
		.read_addr_0(read_addr_0), .read_addr_1(read_addr_1),
		.read_data_0(read_data_0), .read_data_1(read_data_1)
	);

	//ALU
	alu alu_0(
		.op1(rs),
		
	);
	
endmodule