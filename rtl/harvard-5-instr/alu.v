// only ADDU, ADDIU instructions

module alu (
	input logic[31:0] op1, op2,
	input logic[5:0] opcode,
	input logic[5:0] func_code,
	output logic[31:0] alu_out
	// output logic zero
);

	always_comb begin
		casex({opcode, func_code})
			12'b000000100001: alu_out = op1 + op2; // ADDU
			12'b001001??????: alu_out = op1 + op2; // ADDIU
			default: alu_out = 12'hxxx;
		endcase
	end
	
endmodule