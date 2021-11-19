module regfile_tb ();
	
	// inputs
	logic clk, wen, reset;
	logic[31:0] write_data;
	logic[4:0] write_addr;
	logic[4:0] read_addr_0, read_addr_1;
	
	// outputs
	logic[31:0] read_data_0, read_data_1;

	// device under test
	regfile dut(
		.clk(clk), .wen(wen), .reset(reset),
		.write_data(write_data), .write_addr(write_addr),
		.read_addr_0(read_addr_0), .read_addr_1(read_addr_1),
		.read_data_0(read_data_0), .read_data_1(read_data_1)
	);

	// clk & debug waveform
	initial begin
		$dumpfile("regfile_tb.vcd");
		$dumpvars(0, regfile_tb);
		clk = 0;
		repeat(200) begin
			#2;
			clk = !clk;
		end
		$fatal(1, "Simulation ended after 100 clock cycles");
	end

	// testing
	initial begin
		wen = 0;
		reset = 0;
		write_data = 0;
		write_addr = 0;
		read_addr_0 = 0;
		read_addr_1 = 0;

		@(negedge clk);
		reset = 1;
		@(negedge clk);
		reset = 0;
		@(negedge clk);

		// WRITE TEST
		wen = 1;
		write_data = 123;
		write_addr = 3;
		read_addr_0 = 3;

		@(negedge clk);
		wen = 0;
		assert(read_data_0 == 123) else $fatal(2, "Write Failed");

		// READ TEST
		@(negedge clk);
		read_addr_1 = 3;
		@(negedge clk);
		assert(read_data_1 == 123) else $fatal(2, "Read Failed");

		// WRITE TO $zero TEST
		@(negedge clk);
		wen = 1;
		write_data = 111;
		write_addr = 0;
		read_addr_0 = 0;
		@(negedge clk);
		wen = 0;
		assert(read_data_0 == 0) else $fatal(2, "Write to $zero Failed");



		#10;
		$finish;

	end


endmodule