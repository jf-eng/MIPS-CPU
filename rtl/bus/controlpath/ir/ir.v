module ir(
	input logic[31:0] read_data,
    input logic stall,
    input logic clk,
    input logic state,
	output logic[5:0] instruction_opcode,
    output logic[31:0] instruction_word,
    output logic[4:0] rs, rd, rt,
    output logic[4:0] shamt,
    output logic[15:0] alu_immediate,
    output logic[5:0] func_code,
    output logic [4:0] special_branch_codes

);
    logic[31:0] ir_hold, ir_hold_next;
    logic stall_prev;
    
    always @(*) begin
        // muxed IW output
        instruction_word = (state & !stall_prev) ? read_data: ir_hold;

        // bit slicing operations
        instruction_opcode = instruction_word[31:26];
        rs = instruction_word[25:21];
        rt = instruction_word[20:16];
        rd = instruction_word[15:11];
        shamt = instruction_word[10:6];
        alu_immediate = instruction_word[15:0];
        func_code = instruction_word[5:0];
        special_branch_codes = instruction_word[20:16];
    end

    always_ff @(posedge clk) begin
        stall_prev <= stall;

        if(state & !stall_prev) begin // enable for ir_hold
            ir_hold <= read_data;  
        end
    end

endmodule