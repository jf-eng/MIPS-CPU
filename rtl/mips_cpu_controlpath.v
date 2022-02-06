module controlpath(
    // State machine
    input logic clk,
    input logic reset,
    input logic stall,
    output logic state,

    // IR block
    input logic[31:0] instr_readdata,
    output logic[4:0] rs,
    output logic[4:0] rd,
    output logic[4:0] rt,
    output logic[4:0] shamt,
	output logic[15:0] alu_immediate,
    output logic[5:0] instruction_opcode,

    // PC block
    input logic N,
    input logic Z,
    input logic EQ,
    input logic[31:0] read_data_0,
    output logic B_link,
    output logic[31:0] instr_address,
    output logic active,

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
    output logic ShiftAmt,
    output logic ReadHi,
    output logic ReadLo,
    output logic WriteHi,
    output logic WriteLo,
    output logic LUI,
    output logic Var
);
    // State machine
    statemachine statemachine_block(
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .active(active),
        .state(state)
    );

    // IR block
    logic[31:0] instruction_word;
    logic[5:0] func_code;
    logic [4:0] special_branch_codes;
    ir ir_block(
        .read_data(instr_readdata),
        .stall(stall),
        .clk(clk),
        .state(state),
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
        .stall(stall),
        .B_link(B_link),
        .addr(instr_address),
        .active(active)
    );

    // Control block
    control control_block(
        .instruction_opcode(instruction_opcode),
        .func_code(func_code),
        .special_branch_codes(special_branch_codes),
        .state(state),
        .active(active),
        .reset(reset),
        .address(instr_address),
        .B_link(B_link),
        .Var(Var),
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
        .ShiftAmt(ShiftAmt),
        .WriteLo(WriteLo),
        .WriteHi(WriteHi),
        .ReadLo(ReadLo),
        .ReadHi(ReadHi),
        .LUI(LUI)
    );

endmodule