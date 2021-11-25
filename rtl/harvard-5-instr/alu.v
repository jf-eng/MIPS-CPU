// only ADDU, ADDIU instructions

module alu(
	input logic[31:0] op1, op2,
	input logic[5:0] ALUOp,
	input logic[5:0] func_code,
	output logic[31:0] alu_out
);
	logic[11:0] alu_control; // concatenation of opcode and function code

	always_comb begin
		if(ALUOp == 6'b000000) begin
			if(func_code == 6'b100001) begin
				alu_out = op1 + op2; // ADDU
			end
		end
		else begin
			casex (ALUOp)
				6'b001001: alu_out = op1 + op2; // ADDIU
				6'b100011: alu_out = op1 + op2; // LW
				6'b101011: alu_out = op1 + op2; // SW
				default: alu_out = 32'hxxxxxxxx;
			endcase
		end

		// alu_control = {ALUOp, func_code};
		// casex (alu_control)
		// 	(12'b000000100001 || 12'b001001??????): alu_out = op1 + op2;
		// 	default: alu_out = 12'hxxx;
		// endcase
	end
	
endmodule

//TEST FOR PUSHING