module pc_tb();

    logic clk, state, reset, N, Z, B_link, finish;
    logic [31:0] instruction_word, addr, read_data_0;
    
    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);
        clk = 0;
        forever begin
            #1
            clk = !clk;
        end
    end

    logic state_next;
    assign state_next = !state;

    always_ff@(posedge clk) begin
        if(reset)
            state <= 0;
        else
            state <= state_next;
    end
    // initial begin
    //     state = 0;
    //     forever begin
    //         #2
    //         state = !state;
    //     end
    // end

    initial begin
        reset = 0;
        @(negedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        @(negedge clk);

        #1

        instruction_word = 0;
        N = 1;
        #4
        // bugged here!! the pc isnt jumping? cos the jump_selection is not kept long enough for branch delay slot
        instruction_word = 32'b00000100000000000000000000000010; // BLTZ offset of 8
        #4
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        #4
        instruction_word = 0;
        #100;

        $finish;
    end

    pc dut(
        .clk(clk),
        .state(state),
        .reset(reset),
        .N(N),
        .Z(Z),
        .instruction_word(instruction_word),
        .read_data_0(read_data_0),
        .B_link(B_link),
        .addr(addr),
        .finish(finish)
    );
endmodule