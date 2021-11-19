// only ADDU, ADDIU instructions

module alu(
	input logic[31:0] op1, op2,
	input logic add,
	output logic[31:0] alu_out
);

	assign alu_out = (add) ? op1 + op2 : 12'hxxx;
	
endmodule