module ir(
	input logic[31:0] read_data,
	output logic[5:0] instruction_opcode,
    output logic[31:0] instruction_word,
    output logic[4:0] rs, rd, rt,
    output logic[4:0] shamt,
    output logic[15:0] alu_immediate,
    output logic[5:0] func_code,
    output logic [4:0] special_branch_codes

);
    always @(*) begin
        instruction_opcode = read_data[31:26];
        instruction_word = read_data; // need to change for bus interface, add mux and IR reg
        rs = instruction_word[25:21];
        rt = instruction_word[20:16];
        rd = instruction_word[15:11];
        shamt = instruction_word[10:6];
        alu_immediate = instruction_word[15:0];
        func_code = instruction_word[5:0];
        special_branch_codes = instruction_word[20:16];
    end

endmodule