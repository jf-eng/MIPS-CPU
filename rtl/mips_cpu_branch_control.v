/* 
    This module decides whether a branch/jump should be executed or not.

    There are 12 branch/jump instructions in total.

    Take note that JALR (Jump and link register) is the only link instruction that stores PC+8 in Rd instead of $31

    New control logic [1:0] jump_addr_selection is defined as such
        if 00: no jump;
        if 01: absolute jump (JR,JALR);
        if 10: page absolute jump (J,JAL);
        if 11: pc relative branch (all branch instructions);

    Written by JF
*/

module branch_control(
    input logic N, // high if rs is negative
    input logic Z, // high if rs is zero
    input logic EQ, // high if rs == rt
    input logic[31:0] instruction_word, //taking in the entire word bc of repeated branch opcodes like JALR,JR,BGEZ,BGEZAL,BLTZ,BLTZAL
    input logic state,
    input logic stall,
    input logic clk,

    output logic B_link, // high if we want the PC+8 addr to be stored in $31
    output logic [1:0] jump_addr_selection // defined above
);

    logic[1:0] jump_addr_selection_next;

    always @(*) begin
        if (!stall) begin
            case (instruction_word[31:26]) // opcodes
                0: begin
                    if (instruction_word[5:0] == 6'b001001) begin // JALR
                        jump_addr_selection_next = 2'b01; B_link = 1'b1; // B_link is set 1 here; JALR is the only link instruction with RegDst = 1 so that rd is fed as write_addr instead of $31
                    end
                    else if (instruction_word[5:0] == 6'b001000) begin // JR
                        jump_addr_selection_next = 2'b01; B_link = 1'b0; 
                    end
                    else begin
                        jump_addr_selection_next = 2'b0; B_link = 1'b0;
                    end
                end
                6'b000001: begin // special_branch_codes case
                    if (instruction_word[20:16] == 5'b00001) begin // BGEZ; branch if rs >= 0
                        jump_addr_selection_next = (!N | Z) ? 2'b11 : 2'b0; 
                        B_link = 1'b0;
                    end
                    else if (instruction_word[20:16] == 5'b10001) begin // BGEZAL; branch if rs >= 0
                        jump_addr_selection_next = (!N | Z) ? 2'b11 : 2'b0; 
                        B_link = 1'b1;
                    end
                    else if (instruction_word[20:16] == 0) begin // BLTZ; branch if rs < 0
                        jump_addr_selection_next = (N) ? 2'b11 : 2'b0;
                        B_link = 1'b0;
                    end
                    else if (instruction_word[20:16] == 5'b10000) begin // BLTZAL; branch if rs < 0
                        jump_addr_selection_next = (N) ? 2'b11 : 2'b0;
                        B_link = 1'b1;
                    end
                    else begin
                        jump_addr_selection_next = 2'b0; B_link = 1'b0;
                    end
                end
                6'b000010: begin // J
                    jump_addr_selection_next = 2'b10; B_link = 1'b0;
                end
                6'b000011: begin // JAL
                    jump_addr_selection_next = 2'b10; B_link = 1'b1;
                end
                6'b000100: begin // BEQ; branch if rs==rt
                    jump_addr_selection_next = (EQ) ? 2'b11 : 2'b0;
                    B_link = 1'b0;
                end
                6'b000101: begin // BNE; branch if rs!=rt
                    jump_addr_selection_next = (!EQ) ? 2'b11 : 2'b0;
                    B_link = 1'b0;
                end
                6'b000110: begin // BLEZ; branch if rs <= 0
                    jump_addr_selection_next = (N | Z) ? 2'b11 : 2'b0;
                    B_link = 1'b0;
                end
                6'b000111: begin // BGTZ; branch if rs > 0
                    jump_addr_selection_next = (!N & !Z) ? 2'b11 : 2'b0;
                    B_link = 1'b0;
                end
                default: begin // otherwise, dont jump
                    jump_addr_selection_next = 2'b0; B_link = 1'b0;
                end
            endcase
            B_link = (state) ? B_link : 1'b0; // B_link should only be high in EXEC bc its used as RegWrite
        end else begin // if stall, loop values back
            jump_addr_selection_next = jump_addr_selection;
            B_link = 1'b0;
        end

    end

    // at every EXEC, update FF
    // delay needed so that PC only jumps after branch delay slot
    always_ff @(posedge clk) begin
        if (!state) begin // update jump_addr_selection at end of FETCH (edge case is jump/branch instruction, LW (stall))
            jump_addr_selection <= jump_addr_selection_next;
        end
    end
endmodule