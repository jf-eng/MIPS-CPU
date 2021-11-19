module mips_cpu_harvard_tb();

    logic clk;
    logic reset;
    logic active;
    logic [31:0] register_v0;

    /* New clock enable. See below. */
    logic clk_enable; /* Combinatorial read access to instructions */
    logic[31:0] instr_address;
    logic[31:0] instr_readdata;

    /* Combinatorial read and single-cycle write access to instructions */
    logic[31:0] data_address;
    logic data_write;
    logic data_read;
    logic[31:0] data_writedata;
    logic[31:0] data_readdata;

    logic [31:0] instruction_word;
    logic [31:0] source_register_1_data;
    logic [31:0] source_register_2_data;
    logic [31:0] destination_register_data;
    

    mips_cpu_harvard dut(
        .clk(clk),
        .reset(reset),
        .active(active),
        .register_v0(register_v0),
        .clk_enable(clk_enable),
        .instr_address(instr_address),
        .instr_readdata(instr_readdata),
        .data_address(data_address),
        .data_write(data_write),
        .data_read(data_read),
        .data_writedata(data_writedata),
        .data_readdata(data_readdata),
        .instruction_word(instruction_word)
    );
    
    initial begin
        clk = 0;
        repeat (100) begin
        #2;
        clk = !clk;
        end
        $finish(0);
    end

    initial begin
        instruction_word = 32'b00100101010000100000000001000101;
        @(posedge clk) begin
            repeat(10) begin
                #1;
                assert (destination_register_data == source_register_1_data + instruction_word[15:0]);
                instruction_word[15:0] += 16'h1235;
            end
        end
    end

endmodule

//JR $10:
//00000001010000000000000000001000
//ADDU $2, $3, $3:
//00000000011001000001000000010101
//ADDIU $10, $2, 69:
//00100101010000100000000001000101
//LW $8, $7:
//10001101000001110000000000000000
//SW $2, $4:
//10101100100000100000000000000000

