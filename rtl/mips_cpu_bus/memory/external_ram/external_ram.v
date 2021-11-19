module external_ram (
	input logic[31:0] addr,
	input logic[31:0] write_data,
	input logic clk, wen,
	output logic[31:0] data_out
);
	parameter RAM_INIT_FILE = "test.mem";

	reg [31:0] ram [4294967295:0];
	
	initial begin
		for(integer i = 0; i < 4294967296; i=i+1) begin
			ram[i] = 0;
		end
		if (RAM_INIT_FILE != "") begin
			$display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);             $readmemh(RAM_INIT_FILE, memory);
			$readmemh(RAM_INIT_FILE, ram);
		end
	end

	assign data_out = read ? ram[addr] : 32'hxxxxxxxx;

	always_ff @(posedge clk) begin
		if(wen) begin
			ram[addr] <= write_data;
		end
	end

	
endmodule