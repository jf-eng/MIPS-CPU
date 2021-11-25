/*
    Written by JF

    Branch delay slot, B_link results, jumps as expected
*/
module pc_tb();

    logic clk, state, reset, N, Z, B_link, finish;
    logic [31:0] instruction_word, addr, read_data_0;
    integer testcase;
    
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

        #3

        instruction_word = 0;
        @(posedge state);

        //test case of BLTZ offset of 8 w/ condition fulfilled
        testcase = 0;
        N = 1;
        instruction_word = 32'b00000100000000000000000000000010; // BLTZ offset of 8
        @(posedge state);
        // #4
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        @(posedge state);
        // #4
        instruction_word = 0; // non branch/jump
        @(posedge state);
        // #4 

        //test case of BLTZ offset of 8 w/ condition not fulfilled
        testcase = 1;
        N = 0;
        instruction_word = 32'b00000100000000000000000000000010; // BLTZ offset of 8
        @(posedge state);
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        @(posedge state);
        instruction_word = 0; // non branch/jump
        @(posedge state);

        // test case of BGEZAL offset of 8 w/ condition fulfilled
        testcase = 2;
        N = 0; Z = 1;
        instruction_word = 32'b00000100000100010000000000000010; // BGEZAL offset of 8 
        @(posedge state); 
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        @(posedge state); 
        instruction_word = 0; // non branch/jump
        @(posedge state);

        // test case of BGEZAL offset of 8 w/ condition unfulfilled
        testcase = 3;
        N = 1; Z = 0;
        instruction_word = 32'b00000100000100010000000000000010; // BGEZAL offset of 8 
        @(posedge state);
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        @(posedge state);
        instruction_word = 0; // non branch/jump
        @(posedge state);

        // test case of JAL, page jump to 0b0000000000000000000000000100;
        testcase = 4;
        // N = 1; Z = 0;
        instruction_word = 32'b00001100000000000000000000000001; // JAL, page jump to 0b0000000000000000000000000100;
        @(posedge state);
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        @(posedge state);
        instruction_word = 0; // non branch/jump
        @(posedge state);

        // test case of JALR, absolute jump to 0b1;
        testcase = 5;
        // N = 1; Z = 0;
        read_data_0 = 1;
        instruction_word = 32'b00000000000000000000000000001001; // JALR, absolute jump to 0b1;
        @(posedge state);
        instruction_word = 32'b00000000011000000000000000001011; // non branch/jump 
        @(posedge state);
        instruction_word = 0; // non branch/jump
        @(posedge state);

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