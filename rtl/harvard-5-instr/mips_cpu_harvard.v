module mips_cpu_harvard(
    /* Standard signals */
    input logic     clk,
    input logic     reset,
    output logic    active,
    output logic [31:0] register_v0,

    /* New clock enable. See below. */
    input logic     clk_enable,

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

    controlpath controlpathblock(
        .read_data, // from memory bus
        .register_content, // from regfile
        .clk(clk),
        .rs(), //output
        .rd(),
        .rt(),
        .RegDst,
        .Branch,
        .MemRead,
        .MemtoReg,
        .ALUOp,
        .MemWrite,
        .ALUSrc,
        .RegWrite,
        .read_addr 
    );

    datapath datapathblock(

    );

// BFC0 0000
//       |
// BFC0 FFFF
// reg [31:0] ram [4294967296 - 1:0]; this is what we want

// reg [31:0] ram [65536 - 1:0];



endmodule