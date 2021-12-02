module mips_cpu_bus(
    /* Standard signals */
    input logic clk,
    input logic reset,
    output logic active,
    output logic[31:0] register_v0,

    /* Avalon memory mapped bus controller (master) */
    output logic[31:0] address,
    output logic write,
    output logic read,
    input logic waitrequest,
    output logic[31:0] writedata,
    output logic[3:0] byteenable,
    input logic[31:0] readdata
);


	initial begin
		// finished initial reset
		@(negedge reset);

		// slack
		@(negedge clk);
		@(negedge clk);

		// wait until ram is valid
		@(negedge waitrequest);
		read <= 0;
		write <= 1;
		address <= 32'h4;
		writedata <= 32'hAABBCCDD;
		byteenable <= 4'b1100;

		@(negedge waitrequest);
		read <= 0;
		write <= 1;
		address <= 32'h4;
		writedata <= 32'hFFFFCCDD;
		byteenable <= 4'b0011;
		
		@(negedge waitrequest);
		read <= 1;
		write <= 0;
		address <= 32'h4;
		writedata <= 32'hFFFFCCDD;
		byteenable <= 4'b1111;

		@(negedge waitrequest);
		read <= 0;
		write <= 1;
		address <= 32'h0;
		writedata <= 32'hFFFFCCDD;
		byteenable <= 4'b0010;


		#40;

		$finish;
	end


endmodule