module mips_cpu_harvard_tb (
	output logic active,
	output logic[31:0] register_v0
);
	
    logic clk;
    logic reset;

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
        .data_readdata(data_readdata)
    );

    // CLK
    initial begin
        $dumpfile("mips_cpu_harvard_tb.vcd");
        $dumpvars(0, mips_cpu_harvard_tb);
        clk = 0;
        repeat (600) begin
            #2;
            clk = !clk;
        end
        $fatal(2, "Simulation ended in 300 clock cycles");
    end

    // RAM & ROM
    reg [31:0] rom [0:255];
    reg [31:0] ram [0:255];

    parameter ROM_INIT_FILE = ".rom";
    parameter RAM_INIT_FILE = ".ram";

    // RAM ROM initialisation
    initial begin
        for(integer i = 0; i < 255; i=i+1) begin
            rom[i] = 0;
            ram[i] = 0;
        end

        if (ROM_INIT_FILE != "") begin
            $display("ROM : INIT : Loading ROM contents from %s", ROM_INIT_FILE);
            $readmemb(ROM_INIT_FILE, rom);
        end

        if (RAM_INIT_FILE != "") begin
            $display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);
            $readmemb(RAM_INIT_FILE, ram);
        end
    end

    // ROM and RAM READ
    logic [7:0] rom_wordaddr, ram_wordaddr;
    assign rom_wordaddr = instr_address[7:0] >> 2;
    assign ram_wordaddr = data_address[7:0] >> 2;

    assign instr_readdata = (instr_address[31:8] == 24'hBFC000) ? rom[rom_wordaddr] :
            (data_address == 0) ? 0 : 32'hxxxxxxxx;
    assign data_readdata = (data_read && data_address[31:8] == 24'h000000) ? ram[ram_wordaddr] : 32'hxxxxxxxx;

    // RAM WRITE
    always_ff @(posedge clk) begin
        if(data_write && data_address[31:8] == 24'h000000) begin
            ram[data_address[7:0]] <= data_writedata;
        end
    end

    // TESTING
    initial begin
        // $monitor("Time %t:\n[ROM] PC: %h, WordADDR: %h, Instruction: %h\n[CPU] Active: %d, Register_v0 ($2): %h",
        //         $time, instr_address, rom_wordaddr, instr_readdata, active, register_v0);

        reset = 0;
        @(negedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;

        @(negedge active); // wait until cpu ends

    end

endmodule