module alu(
	input logic clk,
	input logic[31:0] op1, op2,
	input logic Add, Sub, Mul, Div, Unsigned, WriteHi, WriteLo,
	input Or, And, Xor, Sl, Sr, Arithmetic, Boolean,
	output logic[31:0] alu_out, hi, lo,
	output logic n, z, eq
);

logic [31:0] subtractedUnsigned, subtractedSigned;
assign subtractedUnsigned = op1-op2;
assign subtractedSigned = op1[30:0] - op2[30:0];

always_comb begin
	if(Add) begin //addition: add both operands
		alu_out = op1 + op2;
	end

	if(Sub) begin //subtraction: subtract op2 from op1
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
			alu_out = op1 >>> op2; //3 arrows = arithmetic
		end else begin
			alu_out = op1 >> op2;
		end
	end

end

always @(*) begin //in always * because bit select not supported in always_comb
	if(Boolean) begin
		if(Unsigned || !(op1[31] && op2[31])) begin //want to subtract if we are either working with unsigned numbers or at least one signed number is positive
			alu_out <= {
					31'h00000000,
					subtractedUnsigned[31]
				}; //put 31 0s on front of msb of op1 - op2
		end else begin
			alu_out <= {
					31'h00000000,
					subtractedSigned[31]
				}; //put 31 0s on front of msb of 30 lsb bits of op1 - 30 lsb bits of op2
		end
	end

	
end

logic[63:0] multiplied, divided; //for the 64 bit result of multiplicaiton / division
logic [63:0] op1se, op2se; //sign extended op1 and op2 for 64 bit

assign op1se = Unsigned || (!Unsigned && !op1[31]) ? {32'h00000000, op1} : {32'h11111111, op1}; //if unsigned, we want 0 extened; if signed and msb is 0, we want 0 extended; else, we want 1 extended
assign op2se = Unsigned || (!Unsigned && !op2[31]) ? {32'h00000000, op2} : {32'h11111111, op2}; //if unsigned, we want 0 extened; if signed and msb is 0, we want 0 extended; else, we want 1 extended
assign multiplied = op1se * op2se;

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

	

	//TODO DIVISION LATER
end

endmodule