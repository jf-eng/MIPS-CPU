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