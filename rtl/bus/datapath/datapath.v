module datapath(
    input logic clk,

    // Load & Store "Blocks"
    input logic[5:0] opcode,
    output logic[31:0] data_writeaddr,
    output logic[31:0] data_readaddr,
    output logic[3:0] byteenable,

    // regfile
    input logic reset,
    input logic RegWrite,
    input logic [31:0] instr_address, // for pc + 8
    input logic MemtoReg,
    input logic[31:0] data_readdata,
    input logic RegDst,
    input logic B_link,
    input logic[4:0] rd,
    input logic[4:0] rt,
    input logic[4:0] rs,
    output logic[31:0] read_data_0,
    output logic[31:0] register_v0,
    output logic[31:0] data_writedata,

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
    input logic WriteHi,
    input logic WriteLo,
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

    /*Load "block" - determines what input to regfile write data should be for load instructions
        Inputs: opcode, read_data_1, data_readdata, alu_out (ie effective address)
        Outputs: load_data, data_readaddr, byteenable
    */ 
    logic[31:0] load_data;

    always_comb begin
        case (opcode)
            6'b100011: begin // LW
                data_readaddr = alu_out;
                load_data = data_readdata;
                byteenable = 4'b1111;
            end
            6'b100000: begin // LB 
                data_readaddr = {alu_out[31:2],2'b0};
                case (alu_out[1:0]) // assumes big endian, sign extension
                    2'b00: load_data = {{24{data_readdata[31]}},data_readdata[31:24]};
                    2'b01: load_data = {{24{data_readdata[23]}},data_readdata[23:16]};
                    2'b10: load_data = {{24{data_readdata[15]}},data_readdata[15:8]};
                    2'b11: load_data = {{24{data_readdata[7]}},data_readdata[7:0]};
                endcase
                byteenable = 4'b1111;
            end
            6'b100100: begin // LBU
                data_readaddr = {alu_out[31:2],2'b0};
                case (alu_out[1:0]) // assumes big endian, zero extend
                    2'b00: load_data = {24'h0,data_readdata[31:24]};
                    2'b01: load_data = {24'h0,data_readdata[23:16]};
                    2'b10: load_data = {24'h0,data_readdata[15:8]};
                    2'b11: load_data = {24'h0,data_readdata[7:0]};
                endcase
                byteenable = 4'b1111;
            end
            6'b100001: begin // LH
                data_readaddr = {alu_out[31:2],2'b0};
                case (alu_out[1]) // assumes big endian, sign extend
                    0: load_data = {{16{data_readdata[31]}},data_readdata[31:16]};
                    1: load_data = {{16{data_readdata[31]}},data_readdata[15:0]};
                endcase
                byteenable = 4'b1111;
            end
            6'b100101: begin // LHU
                data_readaddr = {alu_out[31:2],2'b0};
                case (alu_out[1]) // assumes big endian, zero extend
                    0: load_data = {16'h0,data_readdata[31:16]};
                    1: load_data = {16'h0,data_readdata[15:0]};
                endcase
                byteenable = 4'b1111;
            end
            6'b100010: begin // LWL;  alu_out is most significant byte of unaligned word
                byteenable = 4'b1111;
                // not yet implemented
            end
            6'b100110: begin // LWR; alu_out is least significant byte of unaligned word
                byteenable = 4'b1111;
                // not yet implemented
            end
            default: begin
                byteenable = 
            end

        endcase
    end


    // Regfile
    logic[31:0] write_data, read_data_1;
    logic [4:0] write_addr;
    always_comb begin
        // logic for write_addr to regfile
        if(B_link) begin
            if(RegDst) begin // high for JALR (all other B_link instructions has RegDst = 0)
                write_addr = rd;
            end else begin
                write_addr = 32'd31; // $31 for all other B_link instructions
            end
        end else begin
            write_addr = (RegDst) ? rd : rt;
        end

        // logic for write_data to regfile
        if(MemtoReg) begin
            write_data = load_data;
        end else begin
            write_data = (B_link) ? instr_address + 8 : alu_out;
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
            op2 = (ShiftAmt) ? {{27{shamt[4]}}, shamt} : // sign extension of shamt
                (Xor | And | Or) ? {16'h0000, alu_immediate} : {{16{alu_immediate[15]}}, alu_immediate};  // sign or zero extend of alu_immediate
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

    /*
    Store "block" - Used for all store instructions
        Inputs: opcode, read_data_1, alu_out (ie effective address),
        Outputs: data_writeaddr, data_writedata, byteenable
    */
    always_comb begin
        case(opcode)
            6'b101011: begin // SW
                data_writedata = read_data_1;
                byteenable = 4'b1111;
                data_writeaddr = alu_out;
            end
            6'b101000: begin // SB
                data_writeaddr = {alu_out[31:2], 2'b0};

                case (alu_out[1:0]) // to determine which effective address byte should be stored at
                    2'b00: begin
                        data_writedata = {24'h0, read_data_1[7:0]};
                        byteenable = 4'b0001;
                    end
                    2'b01: begin
                        data_writedata = {16'h0, read_data_1[7:0], 8'h0};
                        byteenable = 4'b0010;
                    end
                    2'b10: begin
                        data_writedata = {8'h0, read_data_1[7:0], 16'h0};
                        byteenable = 4'b0100;
                    end
                    2'b11: begin
                        data_writedata = {read_data_1[7:0], 24'h0};
                        byteenable = 4'b1000;
                    end
                endcase
            end
            6'b101001: begin // SH
                data_writeaddr = {alu_out[31:2], 2'b0};
                case(alu_out[1])
                    0: begin
                        data_writedata = {16'h0, read_data_1[15:0]};
                        byteenable = 4'b0011;
                    end
                    1: begin
                        data_writedata = {read_data_1[15:0], 16'h0};
                        byteenable = 4'b1100;
                    end
                endcase
            end
            default: begin // all other instructions (non store instructions)
                data_writedata = 32'hx;
                byteenable = 4'bx;
                data_writeaddr = 32'hx;
            end
        endcase
    end
endmodule