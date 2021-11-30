module mips_cpu_harvard(
    /* Standard signals */
    input logic     clk,
    input logic     reset,
    output logic    active,
    output logic [31:0] register_v0,

    // We ignore this input cos its not required for bus cpu anyway
    // /* New clock enable. See below. */ 
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

    // Regfile
    logic RegWrite;
    logic MemtoReg;
    logic RegDst;
    logic B_link;
    logic[4:0] rd;
    logic[4:0] rt;
    logic[4:0] rs;
    logic[31:0] read_data_0;

    // alu
    logic ALUSrc;
    logic ShiftAmt;
    logic[4:0] shamt;
    logic[15:0] alu_immediate;
    logic Add;
    logic Sub;
    logic Mul;
    logic Div;
    logic Unsigned;
    logic WriteHi; // missing from control.v
    logic WriteLo; // missing from control.v
    logic Or;
    logic And;
    logic Xor;
    logic SL;
    logic SR;
    logic Arithmetic;
    logic Boolean;
    logic ReadHi;
    logic ReadLo;
    logic N;
    logic Z;
    logic EQ;
    logic LUI;
    logic[31:0] alu_out;

    // IR block

    // PC block
    logic finish;

    // Control block
    logic R31;

//     // ACTIVE LATCH
    always_ff @(posedge clk) begin
        if(reset)
            active <= 1;
        if(finish)
            active <= 0;
    end

    controlpath controlpathblock(
        .clk(clk),
        .reset(reset),
        .instr_readdata(instr_readdata),
        .rs(rs),
        .rd(rd),
        .rt(rt),
        .shamt(shamt),
        .alu_immediate(alu_immediate),
        .N(N),
        .Z(Z),
        .EQ(EQ),
        .read_data_0(read_data_0),
        .B_link(B_link),
        .instr_address(instr_address),
        .finish(finish),
        .RegDst(RegDst),
        .MemRead(data_read),
        .MemtoReg(MemtoReg),
        .MemWrite(data_write),
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
        .ShiftAmt(ShiftAmt),
        .ReadHi(ReadHi),
        .ReadLo(ReadLo),
        .WriteHi(WriteHi),
        .WriteLo(WriteLo),
        .LUI(LUI)
    );

    datapath datapathblock(
        .clk(clk),
        
        // regfile
        .reset(reset),
        .RegWrite(RegWrite),
        .instr_address(instr_address),
        .MemtoReg(MemtoReg),
        .data_readdata(data_readdata),
        .RegDst(RegDst),
        .B_link(B_link),
        .rd(rd),
        .rt(rt),
        .rs(rs),
        .read_data_0(read_data_0),
        .register_v0(register_v0),

        // alu
        .ALUSrc(ALUSrc),
        .ShiftAmt(ShiftAmt),
        .shamt(shamt),
        .alu_immediate(alu_immediate),
        .Add(Add),
        .Sub(Sub),
        .Mul(Mul),
        .Div(Div),
        .Unsigned(Unsigned),
        .WriteHi(WriteHi),
        .WriteLo(WriteLo),
        .Or(Or),
        .And(And),
        .Xor(Xor),
        .SL(SL),
        .SR(SR),
        .Arithmetic(Arithmetic),
        .Boolean(Boolean),
        .ReadHi(ReadHi),
        .ReadLo(ReadLo),
        .N(N),
        .Z(Z),
        .EQ(EQ),
        .alu_out(data_address),
        .LUI(LUI),
        .data_writedata(data_writedata)
    );


endmodule