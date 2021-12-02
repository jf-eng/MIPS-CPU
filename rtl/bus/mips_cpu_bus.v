module mips_cpu_bus(
    /* Standard signals */
    input logic clk,
    input logic reset,
    output logic active,
    output logic[31:0] register_v0,

    /* Avalon memory mapped bus controller (master) */
    output logic[31:0] address,
    output logic write,
    output logic read,
    input logic waitrequest,
    output logic[31:0] writedata,
    output logic[3:0] byteenable,
    input logic[31:0] readdata
);

    logic stall, stall_prev, valid_data, read_prev;
    assign stall = waitrequest & (read | write);
    assign valid_data = !stall_prev & read_prev;

    // ACTIVE LATCH
    always_ff @(posedge clk) begin
        stall_prev <= stall;
        read_prev <= read;
        if(reset) begin
            active <= 1;
        end
        if(finish) begin
            active <= 0;
        end
    end

    // Selection of address to be fed to RAM
    logic[31:0] data_writeaddr, data_readaddr, instr_address;
    always_comb begin
        if(!state) begin // for FETCH
            address = instr_address;
        end else begin // for EXEC
            if(read) begin
                address = data_readaddr;
            end
            if (write) begin
                address = data_writeaddr;
            end
        end
    end

    // Intermediate signals
    // Regfile
    logic RegWrite;
    logic MemtoReg;
    logic RegDst;
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
    logic WriteHi;
    logic WriteLo;
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

    // IR block
    logic[5:0] opcode;

    // PC block
    logic B_link;
    logic finish;

    // statemachine
    logic state;

    // controlpath
    controlpath controlpath_block(
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .state(state),
        .instr_readdata(readdata),
        .rs(rs),
        .rd(rd),
        .rt(rt),
        .shamt(shamt),
	    .alu_immediate(alu_immediate),
        .instruction_opcode(opcode),
        .N(N),
        .Z(Z),
        .EQ(EQ),
        .read_data_0(read_data_0),
        .B_link(B_link),
        .instr_address(instr_address),
        .finish(finish),
        .RegDst(RegDst),
        .MemRead(read),
        .MemtoReg(MemtoReg),
        .MemWrite(write),
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
        .ReadHi(ReadHi),
        .ReadLo(ReadLo),
        .WriteHi(WriteHi),
        .WriteLo(WriteLo),
        .LUI(LUI)
    );

    // datapath
    datapath datapath_block(
        .clk(clk),
        .valid_data(valid_data),
        .state(state),
        .opcode(opcode),
        .data_writeaddr(data_writeaddr),
        .data_readaddr(data_readaddr),
        .byteenable(byteenable),
        .reset(reset),
        .RegWrite(RegWrite),
        .instr_address(instr_address),
        .MemtoReg(MemtoReg),
        .data_readdata(readdata),
        .RegDst(RegDst),
        .B_link(B_link),
        .rd(rd),
        .rt(rt),
        .rs(rs),
        .read_data_0(read_data_0),
        .register_v0(register_v0),
        .data_writedata(writedata),
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
        .LUI(LUI),
        .N(N),
        .Z(Z),
        .EQ(EQ)
    );



endmodule