module controlpath (
	input logic[31:0] instr_read_data, // from memory bus
	input logic[31:0] reg_read_data_0, // from regfile for JR
	input logic clk, reset,
	output logic[15:0] alu_immediate,
	output logic[4:0] rs, rd, rt, shamt,
	output logic RegDst,
	output logic Branch,
	output logic MemtoReg,
	output logic[5:0] ALUOp,
	output logic ALUSrc,
	output logic RegWrite,
	output logic[31:0] instr_read_addr,
  output logic[5:0] func_code,
	output logic data_read, data_write,
	output logic cpu_halt
);

	logic[31:0] instruction_word;
	logic[5:0] instruction_opcode;
	logic halt;
	assign cpu_halt = halt;

	ir irblock(
		.read_data(instr_read_data), //input
		.instruction_opcode(instruction_opcode), //output
		.instruction_word(instruction_word), //output
		.rs(rs), //output
		.rd(rd), //output
		.rt(rt), //output
		.shamt(shamt), // output
		.alu_immediate(alu_immediate), //output
		.func_code(func_code) //output
	);

	pc pcblock(
		.reset(reset),
		.immediate(Branch), // input
		.Rd(reg_read_data_0), //register content for immediate addressing; input
		.clk(clk), //clock; input
		.halt(halt), // cpu halt input
		.addr(instr_read_addr) //the output address; output
	);

	control controlblock(
		.instruction_opcode(instruction_opcode), //input
		.func_code(func_code),
		.RegDst(RegDst), //output
		.Branch(Branch), //output
		.MemRead(data_read), //output
		.MemtoReg(MemtoReg), //output
		.ALUOp(ALUOp), //output
		.MemWrite(data_write), //output
		.ALUSrc(ALUSrc), //output
		.RegWrite(RegWrite), //output
		.halt(halt) // output
	);

endmodule
