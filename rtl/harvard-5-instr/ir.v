module ir(
	input logic[31:0] read_data,
	output logic[5:0] instruction_opcode,
    output logic[31:0] instruction_word,
    output logic[4:0] rs, rd, rt,
    output logic[15:0] alu_immediate,
    output logic[5:0] func_code

);
    always @(*) begin
        instruction_opcode = read_data[31:26];
        instruction_word = read_data; // need to change for bus interface, add mux and IR reg
        rs = instruction_word[25:21];
        rt = instruction_word[20:16];
        rd = instruction_word[15:11];
        alu_immediate = instruction_word[15:0];
        func_code = instruction_word[5:0];

        // if (instruction_opcode == 0) begin
        //     func_code = instruction_word[5:0];
        // end else begin
        //     func_code = 6'bxxxxxx;
        // end
    end

endmodule