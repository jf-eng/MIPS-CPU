module datapath(
    input logic clk,


    input logic reset,
    input logic RegWrite,
    input logic [31:0] instr_address,
    input logic MemtoReg,
    input logic[31:0] data_readdata,
    input logic RegDst,
    input logic B_link,
    input logic[4:0] rd,
    input logic[4:0] rt,
    input logic[4:0] rs,
    output logic[31:0] read_data_0,
    output logic[31:0] register_v0,

    // alu
    input logic ALUSrc,
    input logic ShiftAmt,
    input logic[4:0] shamt,
    input logic[15:0] alu_immediate,
    input logic Add,
    input logic Sub,
    input logic Mul,
    input logic Div,
    input logic Unsigned,
    input logic WriteHi, // missing from control.v
    input logic WriteLo, // missing from control.v
    input logic Or,
    input logic And,
    input logic Xor,
    input logic SL,
    input logic SR,
    input logic Arithmetic,
    input logic Boolean,
    input logic ReadHi,
    input logic ReadLo,
    input logic LUI,
    output logic N,
    output logic Z,
    output logic EQ,
    output logic[31:0] alu_out
);

    // Regfile
    logic[31:0] write_data, read_data_1;
    logic [4:0] write_addr;
    always_comb begin
        if(B_link) begin
            write_data = instr_address + 8; // PC + 8
            if(RegDst) begin // high for JALR (all other B_link instructions has RegDst = 0)
                write_addr = rd;
            end else begin
                write_addr = 32'd31; // $31 for all other B_link instructions
            end
        end else begin
            write_data = (MemtoReg) ? data_readdata : alu_out;
            write_addr = (RegDst) ? rd : rt;
        end
    end

    logic [4:0] read_addr_0, read_addr_1;
    logic SH;

    assign SH = (SL | SR) & RegDst; //control signal to differentiate between LUI and shift instruction where rs and rt are swapped
    assign read_addr_0 = (SH) ? rt : rs;
    assign read_addr_1 = (SH) ? rs : rt;


    regfile regfile_block(
        .clk(clk),
        .wen(RegWrite),
        .reset(reset),
        .write_data(write_data),
        .write_addr(write_addr),
        .read_addr_0(read_addr_0),
        .read_addr_1(read_addr_1),
        .read_data_0(read_data_0),
        .read_data_1(read_data_1),
        .register_v0(register_v0)
    );

    // ALU
    logic[31:0] op2;


    always @(*) begin
        if(ALUSrc) begin
            op2 = (ShiftAmt) ? {{27{shamt[4]}}, shamt} : {{16{alu_immediate[15]}}, alu_immediate}; //sign extension of shamt or alu_immediate
        end else begin
            op2 = read_data_1;
        end
    end

    alu alu_block(
        .clk(clk),
        .op1(read_data_0),
        .op2(op2),
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
        .Sl(SL),
        .Sr(SR),
        .Arithmetic(Arithmetic),
        .Boolean(Boolean),
        .alu_out(alu_out),
        .n(N),
        .z(Z),
        .eq(EQ),
        .LUI(LUI),
        .ReadHi(ReadHi),
        .ReadLo(ReadLo)
    );
endmodule