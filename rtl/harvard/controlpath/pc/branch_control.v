/* 
    This module decides whether a branch/jump should be executed or not.

    There are 12 branch/jump instructions in total.

    New control logic [1:0] jump_addr_selection is defined as such
        if 00: no jump;
        if 01: absolute jump (JR,JALR);
        if 10: page absolute jump (J,JAL);
        if 11: pc relative branch (all branch instructions);

    Written by JF
*/

module branch_control(
    input logic N, // high if alu_out is negative
    input logic Z, // high if alu_out is zero
    input logic[31:0] instruction_word, //taking in the entire word bc of repeated branch opcodes like JALR,JR,BGEZ,BGEZAL,BLTZ,BLTZAL
    // input logic R31, //taken from control.v; high for link instructions; not needed actually
    input logic state,
    input logic clk,

    // output logic Branch, // high if we want the PC to jump in the next fetch
    output logic B_link, // high if we want the PC+8 addr to be stored in $31
    output logic [1:0] jump_addr_selection // defined above
);

    logic[1:0] jump_addr_selection_next;

    always @(*) begin
        case (instruction_word[31:26]) // opcodes
            0: begin
                if (instruction_word[5:0] == 6'b001001) begin // JALR
                    jump_addr_selection_next = 2'b01; B_link = 1; 
                end
                else if (instruction_word[5:0] == 6'b001000) begin // JR
                    jump_addr_selection_next = 2'b01; B_link = 0; 
                end
                else begin
                    jump_addr_selection_next = 0; B_link = 0;
                end
            end
            6'b000001: begin // special_branch_codes case
                if (instruction_word[20:16] == 5'b00001) begin // BGEZ; assume ALU does either rs - 0 or rs + 0; branch if rs >= 0
                    jump_addr_selection_next = (!N | Z) ? 2'b11 : 0; 
                    B_link = 0;
                end
                else if (instruction_word[20:16] == 5'b10001) begin // BGEZAL; branch if rs >= 0
                    jump_addr_selection_next = (!N | Z) ? 2'b11 : 0; 
                    B_link = (!N | Z) ? 1 : 0;
                end
                else if (instruction_word[20:16] == 0) begin // BLTZ; branch if rs < 0
                    jump_addr_selection_next = (N) ? 2'b11 : 0;
                    B_link = 0;
                end
                else if (instruction_word[20:16] == 5'b10000) begin // BLTZAL; branch if rs < 0
                    jump_addr_selection_next = (N) ? 2'b11 : 0;
                    B_link = (N) ? 1 : 0;;
                end
                else begin
                    jump_addr_selection_next = 0; B_link = 0;
                end
            end
            6'b000010: begin // J
                jump_addr_selection_next = 2'b10; B_link = 0;
            end
            6'b000011: begin // JAL
                jump_addr_selection_next = 2'b10; B_link = 1;
            end
            6'b000100: begin // BEQ; assume alu does rs - rt; branch if rs==rt
                jump_addr_selection_next = (Z) ? 2'b11 : 0;
                B_link = 0;
            end
            6'b000101: begin // BNE; branch if rs!=rt
                jump_addr_selection_next = (!Z) ? 2'b11 : 0;
                B_link = 0;
            end
            6'b000110: begin // BLEZ; branch if rs <= 0
                jump_addr_selection_next = (N | Z) ? 2'b11 : 0;
                B_link = 0;
            end
            6'b000101: begin // BGTZ; branch if rs > 0
                jump_addr_selection_next = (!N) ? 2'b11 : 0;
                B_link = 0;
            end
        default: begin // otherwise, dont jump
            jump_addr_selection_next = 0; B_link = 0;
        end
        endcase
    end

    // at every EXEC, update FF
    // delay needed so that PC only jumps after branch delay slot
    // still bugged altho jump_addr_selection is correct now
    logic [31:0] tmp;
    always_ff @(posedge clk) begin
        if (state) begin
            jump_addr_selection <= tmp;
            tmp <= jump_addr_selection_next;
        end else begin
            jump_addr_selection <= jump_addr_selection;
        end
    end
endmodule