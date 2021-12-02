module ir_tb();

    logic[31:0] read_data, instruction_word;
    logic stall, clk, state, reset;

    initial begin
        $dumpfile("ir_tb.vcd");
        $dumpvars(0, ir_tb);
        clk = 0;
        forever begin
            #2
            clk = !clk;
        end
    end

    logic state_next;
    assign state_next = (stall) ? state : !state;

    always_ff@(posedge clk) begin
        if(reset)
            state <= 0;
        else begin
            state <= state_next;
        end
    end

    initial begin
        reset = 0; stall = 0;
        @(posedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;
        
        @(posedge clk);
        read_data <= 32'hffffffff; // instruction
        @(posedge clk);
        read_data <= 32'h01; // data or garbage

        // add in stalls in exec
        //1 cycle stall
        @(posedge clk);
        read_data <= 32'hfffffffe; // instruction
        stall <= 1;
        @(posedge clk);
        stall <= 0;
        read_data <= 32'hx; // garbage
        @(posedge clk);

        // 2 cycle stall
        @(posedge clk);
        read_data <= 32'hfffffffd; // instruction
        stall <= 1;
        @(posedge clk);
        read_data <= 32'hx; // garbage
        @(posedge clk);
        stall <= 0;
        @(posedge clk);

        // add in stalls in fetch
        // 1 stall
        stall <= 1;
        @(posedge clk);
        stall <=0;


        @(posedge clk);
        read_data <= 32'h01; // data or garbage

        @(posedge state);
        read_data <= 32'hfffffffc; // instruction
        @(negedge state);
        read_data <= 32'h01; // data or garbage

        // 2 stalls
        stall <= 1;
        @(posedge clk);
        @(posedge clk);
        stall <=0;


        @(posedge clk);
        read_data <= 32'h01; // data or garbage

        @(posedge state);
        read_data <= 32'hfffffffb; // instruction
        @(negedge state);
        read_data <= 32'h01; // data or garbage
        @(posedge state);

        $finish;
    end



    ir dut(
        .read_data(read_data),
        .stall(stall),
        .clk(clk),
        .state(state),
        .instruction_word(instruction_word)
    );
endmodule