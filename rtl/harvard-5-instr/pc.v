module pc (
	input logic Branch, // goes high when immediate address required
	input logic [31:0] Rd, //register content for immediate addressing
	input logic clk, reset, halt, state, //clock, reset, halt and state
	output logic [31:0] addr //the output address
);


	logic [31:0] addr_next;

	assign addr_next = (halt || !state) ? addr : 
				  (Branch) ? Rd : addr + 4;

	always_ff @(posedge clk) begin
		if(reset) begin
			addr <= 32'hBFC00000;
		end else begin
			addr <= addr_next;
		end
	end


endmodule
