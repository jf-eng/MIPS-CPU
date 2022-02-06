module alu(
	input logic clk, reset,
	input logic [31:0] op1, op2,
	input logic Add, Sub, Mul, Div, Unsigned, WriteHi, WriteLo, ReadHi, ReadLo,
	input logic Or, And, Xor, Sl, Sr, Arithmetic, Boolean, LUI, Var,
	output logic [31:0] alu_out,
	output logic n, z, eq
);

	logic signed [31:0] op1_s, op2_s;
	logic [31:0] lo, hi;


	assign op1_s = op1;
	assign op2_s = op2;

	always @(*) begin
		alu_out = 32'hx;
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
			if(LUI) begin
				alu_out = op2 << 16;
			end else if (Var) begin
				alu_out = op1 << op2[4:0];
			end else begin
				alu_out = op1 << op2;
			end
		end

		if(Sr) begin
			if(Arithmetic) begin
				if (Var) begin
					alu_out = op1_s >>> (op2[4:0]);
				end else begin
					alu_out = op1_s >>> op2; //3 arrows = arithmetic
				end
			end else if (Var) begin
				alu_out = op1 >> (op2[4:0]);
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

		if(Boolean) begin // SLT SLTU SLTI SLTIU instruction
			if (Unsigned) begin
				alu_out = {31'h0, (op1 < op2)};
			end else begin
				alu_out = {31'h0, (op1_s < op2_s)};
			end
		end
	end

	always @(*) begin
		eq = 1'hx;
		z = 1'hx;
		n = 1'hx;

		if(op1 == op2) begin //checks if equal
			eq = 1;
		end else begin
			eq = 0;
		end

		if(op1[31]) begin //check if negative
			n = 1;
		end else begin
			n = 0;
		end

		if(op1 == 0) begin
			z = 1;
		end else begin
			z = 0;
		end
	end

	logic[63:0] multiplied; //for the 64 bit result of multiplicaiton / division
	logic [63:0] op1se, op2se; //sign extended op1 and op2 for 64 bit
	logic signed [63:0] multiplied_s;

	assign multiplied_s = op1_s * op2_s;
	assign multiplied = op1 * op2;

	always_ff @(posedge clk) begin
		if(reset == 1) begin
			hi <= 0;
			lo <= 0;
		end

		if(Mul) begin //multiplication
			if (Unsigned) begin
				hi <= multiplied[63:32];
				lo <= multiplied[31:0];
			end else begin
				hi <= multiplied_s[63:32];
				lo <= multiplied_s[31:0];
			end
		end

		if(WriteHi) begin //moving to hi
			hi <= op1;
		end

		if(WriteLo) begin //moving to lo
			lo <= op1;
		end

		if(Div) begin
			if(op2 == 0) begin
				lo <= 32'hx;
				hi <= 32'hx;
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