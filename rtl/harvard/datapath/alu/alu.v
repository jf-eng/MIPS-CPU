module alu(
	input logic clk,
	input logic [31:0] op1, op2,
	input logic Add, Sub, Mul, Div, Unsigned, WriteHi, WriteLo, ReadHi, ReadLo,
	input logic Or, And, Xor, Sl, Sr, Arithmetic, Boolean,
	output logic [31:0] alu_out,
	output logic n, z, eq,
	output logic [31:0] hi, lo //TODO delete this
);

logic signed [31:0] op1_s, op2_s;

assign op1_s = op1;
assign op2_s = op2;

logic [31:0] subtractedUnsigned, subtractedSigned;
assign subtractedUnsigned = op1-op2;
assign subtractedSigned = op1[30:0] - op2[30:0];

always_comb begin
	if(Add) begin
		alu_out = op1 + op2;
	end

	if(Sub) begin
		alu_out = op1 - op2;
	end

	if(Or) begin
		alu_out = op1 | op2;
	end
	
	if(And) begin
		alu_out = op1 & op2;
	end

	if(Xor) begin
		alu_out = op1 ^ op2;
	end

	if(Sl) begin
		alu_out = op1 << op2;
	end

	if(Sr) begin
		if(Arithmetic) begin
			alu_out = op1_s >>> op2; //3 arrows = arithmetic
		end else begin
			alu_out = op1 >> op2;
		end
	end

	if(ReadLo) begin
		alu_out = lo;
	end

	if(ReadHi) begin
		alu_out = hi;
	end

end

always @(*) begin //in always * because bit select not supported in always_comb
	if(Boolean) begin
		if(Unsigned || !(op1[31] && op2[31])) begin //want to subtract if we are either working with unsigned numbers or at least one signed number is positive
			alu_out = {
					31'h00000000,
					subtractedUnsigned[31]
				}; //put 31 0s on front of msb of op1 - op2
		end else begin
			alu_out = {
					31'h00000000,
					subtractedSigned[31]
				}; //put 31 0s on front of msb of 30 lsb bits of op1 - 30 lsb bits of op2
		end
	end

	
end

logic[63:0] multiplied; //for the 64 bit result of multiplicaiton / division
logic [63:0] op1se, op2se; //sign extended op1 and op2 for 64 bit


assign multiplied = op1_s * op2_s;

always_ff @(posedge clk) begin
	if(Mul) begin //multiplication
		hi <= multiplied[63:32];
		lo <= multiplied[31:0];
	end

	if(WriteHi) begin //moving to hi
		hi <= op1;
	end

	if(WriteLo) begin //moving to lo
		lo <= op1;
	end

	if(op1 == op2) begin //checks if equal
		eq <= 1;
	end else begin
		eq <= 0;
	end

	if(op1[31]) begin //check if negative
		n <= 1;
	end else begin
		n <= 0;
	end

	if(op1 == 0) begin
		z <= 1;
	end else begin
		z <= 0;
	end

	if(Div) begin
		if(op2 == 0) begin
			lo <= 32'h????????;
			hi <= 32'h????????;
		end else begin
			if(Unsigned) begin
				lo <= op1 / op2;
				hi <= op1 % op2;
			end else begin
				lo <= op1_s / op2_s;
				hi <= op1_s % op2_s;
			end
		end
	end
end

endmodule