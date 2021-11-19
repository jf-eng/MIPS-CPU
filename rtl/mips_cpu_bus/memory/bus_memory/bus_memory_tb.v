module bus_memory_tb ();
	
    logic[31:0] address;
    logic[3:0] byteenable;
    logic[31:0] writedata;
    logic write, read;
    logic waitrequest;
    logic[31:0] readdata;

	external_ram dut(
		.clk(clk),
		.addr(addr), .write_data(write_data), .wen(wen),
		.data_out(data_out)
	);

	initial begin
		clk = 0;
		repeat(200) begin
			#2;
			clk = !clk;
		end
		$fatal(1, "Simulation timed out after 100 clock cycles.");
	end

	initial begin
		addr = 0;
		write_data = 0; wen = 0;
		reset = 0;

		@(negedge clk);
		$display("rom[%d]=%h", addr, data_out);
		addr = 1;
		@(negedge clk);
		$display("rom[%d]=%h", addr, data_out);
		addr = 2;
		@(negedge clk);
		$display("rom[%d]=%h", addr, data_out);
		addr = 3;
		@(negedge clk);
		$display("rom[%d]=%h", addr, data_out);
		@(negedge clk);
		@(negedge clk);
		$finish;
	end

endmodule