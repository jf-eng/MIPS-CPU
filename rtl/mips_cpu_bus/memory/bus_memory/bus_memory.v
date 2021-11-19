module bus_memory (
    input logic[31:0] address,
    input logic[3:0] byteenable,
    input logic[31:0] writedata,
    input logic write, read,
    output logic waitrequest,
    output logic[31:0] readdata
);

	parameter RAM_INIT_FILE = "test.mem";

// READ: read = 1, addr, byteenable -> nextcycle give readdata

// WRITE: write = 1, addr, byteenable, writedata -> single cycle write on clk edge

// INSTRUCTION_START = 32'hBFC00000

	reg [31:0] ram [65535:0]; // only instantiate 2^16 ram
	logic[31:0] read_delay;

	// initialisation of ram to 0
	// TODO: add load from file
	initial begin
		for(integer i = 0; i < 65536; i=i+1) begin
			ram[i] = 0;
		end
		if (RAM_INIT_FILE != "") begin
			$display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);             $readmemh(RAM_INIT_FILE, memory);
			$readmemh(RAM_INIT_FILE, ram);
		end
	end

	always_ff @(posedge clk) begin

		// write
		if(write) begin
			ram[address] <= writedata;
		end

		// 1 cycle delay on read mechanism 
		if(address[31:16] == 16'hBFC0 && read) begin
			read_delay <= ram[address];
		end else begin
			read_delay <= 32'hxxxxxxxx;
		end
		readdata <= read_delay;
	end

endmodule