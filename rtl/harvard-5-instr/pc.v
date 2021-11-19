module pc (
  input logic immediate, // goes high when immediate address required
  input logic [31:0] Rd, //register content for immediate addressing
  input logic clk, //clock
  output logic [31:0] addr //the output address
);

always_ff @(posedge clk) begin //we only want to change register content at posedge
  if(immediate) begin // if immediate high, we want to jump to immediate address taken from the register rd
    addr <= Rd;
  end
  else begin //otherwise we want to increment by 4
    addr <= addr + 4;
  end
end

endmodule