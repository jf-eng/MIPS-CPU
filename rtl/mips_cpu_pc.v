module pc(
    input logic clk,
    input logic state,
    input logic reset,
    input logic N, Z, EQ,
    input logic [31:0] instruction_word,
    input logic [31:0] read_data_0, // register data for JR, JALR
    input logic stall,

    output logic B_link, // bubbled up from branch_control.v so that control.v can make use of it in controlpath.v
    output logic [31:0] addr,
    output logic active
);

    logic [31:0] addr_next, instruction_word_prev, read_data_0_prev;
    logic [1:0] jump_addr_selection; // control signal defined in branch_control.v
    logic active_next;
    
    always @(*) begin
        if(reset) begin
            active_next = 1;
            addr_next = 32'hBFC00000;
        end else if(addr == 0) begin // executing exit instruction address
            active_next = 0;
            addr_next = addr;
        end else if (!stall) begin // update if no stall
            active_next = active;
            case (jump_addr_selection)
                2'b01: addr_next = read_data_0_prev; // absolute jump (JR,JALR);
                2'b10: addr_next = {addr[31:28], instruction_word_prev[25:0], 2'b0}; // page absolute jump (J,JAL);
                2'b11: addr_next = (addr + {{14{instruction_word_prev[15]}}, instruction_word_prev[15:0], 2'b0}); // pc relative branch (all branch instructions);
                default: addr_next = addr + 4;
            endcase
        end else begin // if stall
            active_next = active;
            addr_next = addr;
        end
    end

    always_ff @(posedge clk) begin
        active <= active_next;

        if (reset) begin
            addr<=addr_next;
        end
        else if (state) begin // update PC at end of EXEC
            addr <= addr_next;
        end else begin // update at end of FETCH
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
        .stall(stall),
        .clk(clk),
        .B_link(B_link),
        .jump_addr_selection(jump_addr_selection)
    );
endmodule