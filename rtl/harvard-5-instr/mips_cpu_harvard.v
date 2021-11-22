module mips_cpu_harvard(
    /* Standard signals */
    input logic     clk,
    input logic     reset,
    output logic    active, 
    output logic [31:0] register_v0, 

    /* New clock enable. See below. */
    input logic     clk_enable, //not implemented yet

    /* Combinatorial read access to instructions */
    output logic[31:0]  instr_address,
    input logic[31:0]   instr_readdata,

    /* Combinatorial read and single-cycle write access to instructions */
    output logic[31:0]  data_address,
    output logic        data_write,
    output logic        data_read,
    output logic[31:0]  data_writedata,
    input logic[31:0]  data_readdata
);
    //intermediate signals
    logic[4:0] rs, rt, rd, shamt;
    logic RegDst, Branch, MemtoReg, ALUSrc, RegWrite;
    logic[15:0] alu_immediate;
    logic[31:0] reg_read_data_0;
    logic[5:0] func_code, ALUOp;
    logic cpu_halt;

    // CPU HALTING & ACTIVE LATCHES
    always_ff @(posedge clk) begin
        if(reset)
            active <= 1;
        if(cpu_halt)
            active <= 0;
    end

    // Control Path
    controlpath controlpathblock(
        .instr_read_data(instr_readdata), //input 
        .reg_read_data_0(reg_read_data_0), //input 
        .clk(clk), .reset(reset),//input
        .alu_immediate(alu_immediate),//output
        .rs(rs), //output
        .rd(rd), //output
        .rt(rt),//output
        .shamt(shamt),
	    .RegDst(RegDst),//output
	    .Branch(Branch),//output
	    .MemtoReg(MemtoReg),//output
	    .ALUOp(ALUOp),//output
	    .ALUSrc(ALUSrc),//output
	    .RegWrite(RegWrite),//output
	    .instr_read_addr(instr_address),//output   
        .func_code(func_code),//output
	    .data_read(data_read),//output  
        .data_write(data_write),//output  
        .cpu_halt(cpu_halt) // cpu halt output
    );

    // Data Path
    datapath datapathblock(
        .clk(clk), //input
        .reset(reset),//input
        .RegDst(RegDst), //input
        .MemtoReg(MemtoReg),//input
        .ALUSrc(ALUSrc),//input
        .RegWrite(RegWrite),//input
        .rs(rs), //input
        .rt(rt), //input
        .rd(rd),//input
        .alu_immediate(alu_immediate),//input
        .data_readdata(data_readdata),//input
        .func_code(func_code), //input
        .ALUOp(ALUOp),//input
        .data_address(data_address), //output
        .data_writedata(data_writedata), //output
        .reg_read_data_0(reg_read_data_0), //output
        .register_v0(register_v0) // regfile[2] output
    );

// BFC0 0000
//         |
// BFC0 00FF
// reg [31:0] ram [0:4294967296 - 1]; this is what we want

// reg [31:0] ram [0:255]; this is what we have at home



endmodule