module controlpath(
    // State machine
    input logic clk,
    input logic reset,

    // IR block
    input logic[31:0] instr_readdata,
    output logic[4:0] rs,
    output logic[4:0] rd,
    output logic[4:0] rt,
    output logic[4:0] shamt,
	output logic[15:0] alu_immediate,

    // PC block
    input logic N,
    input logic Z,
    input logic EQ,
    input logic[31:0] read_data_0,
    output logic B_link,
    output logic[31:0] instr_address,
    output logic finish,

    // Control block
    output logic RegDst,
    output logic MemRead,
    output logic MemtoReg,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite,
    output logic Add,
    output logic Sub,
    output logic Mul,
    output logic Div,
    output logic Unsigned,
    output logic Or,
    output logic And,
    output logic Xor,
    output logic SL,
    output logic SR,
    output logic Arithmetic,
    output logic Boolean,
    output logic R31,
    output logic ShiftAmt
    
);
    // State machine
    logic state;
    statemachine statemachine_block(
        .clk(clk),
        .reset(reset),
        .state(state)
    );

    // IR block
    logic[5:0] instruction_opcode;
    logic[31:0] instruction_word;
    logic[5:0] func_code;
    logic [4:0] special_branch_codes;
    ir ir_block(
        .read_data(instr_readdata),
        .instruction_opcode(instruction_opcode),
        .instruction_word(instruction_word),
        .rs(rs),
        .rd(rd),
        .rt(rt),
        .shamt(shamt),
        .alu_immediate(alu_immediate),
        .func_code(func_code),
        .special_branch_codes(special_branch_codes)
    );

    // PC block
    pc pc_block(
        .clk(clk),
        .state(state),
        .reset(reset),
        .N(N),
        .Z(Z),
        .EQ(EQ),
        .instruction_word(instruction_word),
        .read_data_0(read_data_0),
        .B_link(B_link),
        .addr(instr_address),
        .finish(finish)
    );

    // Control block
    control control_block(
        .instruction_opcode(instruction_opcode),
        .func_code(func_code),
        .special_branch_codes(special_branch_codes),
        .state(state),
        .B_link(B_link),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Add(Add),
        .Sub(Sub),
        .Mul(Mul),
        .Div(Div),
        .Unsigned(Unsigned),
        .Or(Or),
        .And(And),
        .Xor(Xor),
        .SL(SL),
        .SR(SR),
        .Arithmetic(Arithmetic),
        .Boolean(Boolean),
        .R31(R31),
        .ShiftAmt(ShiftAmt)
    );

endmodule