module controlpath (
	input logic[31:0] read_data, // from memory bus
	input logic[31:0] register_content, // from regfile
	input logic clk,
	output logic[4:0] rs, rd, rt,
	output logic RegDst,
	output logic Branch,
	output logic MemRead,
	output logic MemtoReg,
	output logic ALUOp,
	output logic MemWrite,
	output logic ALUSrc,
	output logic RegWrite,
	output logic[31:0] read_addr
);

	logic[31:0] instruction_word;
	logic[5:0] instruction_opcode;

	ir irblock(
		.read_data(read_data), //input
		.instruction_opcode(instruction_opcode), //output
		.instruction_word(instruction_word), //output
		.rs(rs), //output
		.rd(rd), //output
		.rt(rt) //output
	);

	pc pcblock(
		.immediate(Branch), // goes high when immediate address required; input
		.Rd(register_content), //register content for immediate addressing; input
		.clk(clk), //clock; input
		.addr(read_addr) //the output address; output
	);

	control controlblock(
		.instruction_opcode(instruction_opcode), //input
		.RegDst(RegDst), //output
		.Branch(Branch), //output
		.MemRead(MemRead), //output
		.MemtoReg(MemtoReg), //output
		.ALUOp(ALUOp), //output
		.MemWrite(MemWrite), //output
		.ALUSrc(ALUSrc), //output
		.RegWrite(RegWrite) //output
	);
endmodule
