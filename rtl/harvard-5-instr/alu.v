// only ADDU, ADDIU instructions

module alu(
	input logic[31:0] op1, op2,
	input logic[5:0] ALUOp,
	input logic[5:0] func_code,
	output logic[31:0] alu_out
);
	logic[11:0] alu_control; // concatenation of opcode and function code

	always_comb begin
		alu_control = {ALUOp, func_code};
		casex (alu_control)
			(12'b000000100001 || 12'b001001??????): alu_out = op1 + op2;
			default: alu_out = 12'hxxx;
		endcase
	end
	
endmodule