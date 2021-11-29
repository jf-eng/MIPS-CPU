/*
    Written by JF
*/

module pc(
    input logic clk,
    input logic state,
    input logic reset,
    input logic N, Z, EQ,
    input logic [31:0] instruction_word,
    input logic [31:0] read_data_0, // register data for JR, JALR

    output logic B_link, // bubbled up from branch_control.v so that control.v can make use of it in controlpath.v
    output logic [31:0] addr,
    output logic finish // goes high when trying to execute instruction address 0
);

    logic [31:0] addr_next, instruction_word_prev, read_data_0_prev;
    logic [1:0] jump_addr_selection; // control signal defined in branch_control.v
    
    always @(*) begin
        if(addr == 0) begin // executing exit instruction address
            finish = 1;
            addr_next = addr;
        end else begin
            finish = 0;
            case (jump_addr_selection)
                2'b01: addr_next = read_data_0_prev; // absolute jump (JR,JALR);
                2'b10: addr_next = {addr[31:28], instruction_word_prev[25:0], 2'b0}; // page absolute jump (J,JAL);
                2'b11: addr_next = (addr + {14'b0, instruction_word_prev[15:0], 2'b0}); // pc relative branch (all branch instructions);
                default: addr_next = addr + 4;
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            addr <= 32'hBFC00000;
        end else if (state) begin // update PC at end of EXEC
            addr <= addr_next;
            instruction_word_prev <= instruction_word;
            read_data_0_prev <= read_data_0;
        end
    end

    branch_control branch_controlblock(
        .N(N),
        .Z(Z),
        .EQ(EQ),
        .instruction_word(instruction_word),
        .state(state),
        .clk(clk),
        .B_link(B_link),
        .jump_addr_selection(jump_addr_selection)
    );
endmodule