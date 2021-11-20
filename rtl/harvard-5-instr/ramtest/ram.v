module ram ();
	
	reg [15:0] ram [0:200];
	// WARNING: ram.v:10: $readmemh: The behaviour for reg[...] mem[N:0];
	// $readmemh("...", mem); changed in the 1364-2005 standard.
	// To avoid ambiguity, use mem[0:N] or explicit range parameters
	// $readmemh("...", mem, start, stop);. Defaulting to 1364-2005 behavior.

	initial begin
		for(integer i = 0; i < 7; i=i+1) begin
			ram[i] = 0;
		end	

		$readmemh("ram.mem", ram);

		for(integer i = 0; i < 7; i=i+1) begin
			$display("ram[%h]=%h", i, ram[i]);
		end

		$finish;
	end

endmodule