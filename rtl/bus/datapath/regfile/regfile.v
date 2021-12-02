module regfile (
	input logic clk, wen, reset,
	input logic[31:0] write_data,
	input logic[4:0] write_addr,
	input logic[4:0] read_addr_0, read_addr_1,
	output logic[31:0] read_data_0, read_data_1,
	output logic[31:0] register_v0
);

	reg [31:0] regs [0:31];

	assign register_v0 = regs[2];

	logic[31:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16;
	logic[31:0] r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;

	assign r0 = regs[0];
	assign r1 = regs[1];
	assign r2 = regs[2];
	assign r3 = regs[3];
	assign r4 = regs[4];
	assign r5 = regs[5];
	assign r6 = regs[6];
	assign r7 = regs[7];
	assign r8 = regs[8];
	assign r9 = regs[9];
	assign r10 = regs[10];
	assign r11 = regs[11];
	assign r12 = regs[12];
	assign r13 = regs[13];
	assign r14 = regs[14];
	assign r15 = regs[15];
	assign r16 = regs[16];
	assign r17 = regs[17];
	assign r18 = regs[18];
	assign r19 = regs[19];
	assign r20 = regs[20];
	assign r21 = regs[21];
	assign r22 = regs[22];
	assign r23 = regs[23];
	assign r24 = regs[24];
	assign r25 = regs[25];
	assign r26 = regs[26];
	assign r27 = regs[27];
	assign r28 = regs[28];
	assign r29 = regs[29];
	assign r30 = regs[30];
	assign r31 = regs[31];

	always_ff @(posedge clk) begin
		if(reset == 1) begin
			for(integer i = 0; i < 32; i=i+1) begin
				regs[i] <= 0;
			end
		end
		if(wen == 1) begin
			regs[write_addr] <= (write_addr == 0) ? 0 : write_data;
		end
	end

	always_comb begin
		read_data_0 = (read_addr_0 == 0) ? 0 : regs[read_addr_0];
		read_data_1 = (read_addr_1 == 0) ? 0 : regs[read_addr_1];
	end

endmodule