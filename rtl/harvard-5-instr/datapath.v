module datapath(
	input logic clk, reset,
	input logic RegDst, MemtoReg,ALUSrc,RegWrite,
	input logic[4:0] rs, rt, rd,
    input logic[5:0] func_code,ALUOp,
	input logic[15:0] alu_immediate,
	input logic[31:0] data_readdata,
	output logic[31:0] data_address, data_writedata, reg_read_data_0,
	output logic[31:0] register_v0
);

	// REGFILE INPUTS
	logic[31:0] reg_write_data;
	logic[4:0] reg_write_addr;
	logic[4:0] reg_read_addr_0, reg_read_addr_1;

	// REGFILE OUTPUTS
	logic[31:0] reg_read_data_1;

	assign reg_read_addr_0 = rs;
	assign reg_read_addr_1 = rt;
	assign reg_write_addr = (RegDst) ? rt : rd;


	//REGFILE
	regfile regfile_0(
		.clk(clk), .wen(RegWrite), .reset(reset),
		.write_data(reg_write_data), .write_addr(reg_write_addr),
		.read_addr_0(reg_read_addr_0), .read_addr_1(reg_read_addr_1),
		.read_data_0(reg_read_data_0), .read_data_1(reg_read_data_1),
		.register_v0(register_v0)
	);

	logic [31:0] sign_extended;
	assign sign_extended = (alu_immediate[15]) ? {16'hffff, alu_immediate} : {16'h0000, alu_immediate};

	//ALU
	logic add;
	logic[31:0] alu_out;
	logic[31:0] op2;
	assign op2 = (ALUSrc) ? sign_extended : reg_read_data_1;
	alu alu_0(
		.op1(reg_read_data_0),
		.op2(op2),
		.ALUOp(ALUOp),
		.func_code(func_code),
		.alu_out(alu_out)
	);

	// WRAP AROUND RAM
	assign data_address = alu_out;
	assign data_writedata = reg_read_data_1;
	
	assign reg_write_data = (MemtoReg) ? data_readdata : alu_out;  



	
endmodule