module ir(
	input logic[31:0] read_data,
	output logic[5:0] instruction_opcode,
    output logic[31:0] instruction_word,
    output logic[4:0] rs, rd, rt;
);
    always_comb begin
        instruction_opcode = read_data[31:26];
        read_data = instruction_word; // need to change for bus interface, add mux and IR reg
        rs = instruction_word[25:21];
        rt = instruction_word[20:16];
        
    end

endmodule