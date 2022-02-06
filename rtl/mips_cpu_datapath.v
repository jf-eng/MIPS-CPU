module datapath(
    input logic clk,
    input logic valid_data,
    input logic state,

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
    input logic Var,
    output logic N,
    output logic Z,
    output logic EQ
);
    /* Store & Load 'blocks' are just 1 always_comb block below
    Store "block" - Used for all store instructions
        Inputs: opcode, read_data_1, alu_out (ie effective address),
        Outputs: data_writeaddr, data_writedata, byteenable
    
    Load "block" - determines what input to regfile write data should be for load instructions
        Inputs: opcode, read_data_1, data_readdata, alu_out (ie effective address)
        Outputs: load_data, data_readaddr, byteenable
    */ 
    logic[31:0] load_data;
    logic[1:0] addr_offset_prev;

    /*
    Since alu_out is combinatorial, addr_offset_prev stores the the byte offset for one cycle
    so that load byte operations can perform the correct writeback of data to REGFILE in FETCH
    */
    always_ff @(posedge clk) begin
        addr_offset_prev <= alu_out[1:0]; 
    end

    always@(*) begin
        data_writedata = 32'hx;
        byteenable = 4'bx;
        data_writeaddr = 32'hx;
        load_data = alu_out;
        data_readaddr = 32'hx;

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
                        data_writedata = {read_data_1[7:0], 24'h0};
                        byteenable = 4'b0001;
                    end
                    2'b01: begin
                        data_writedata = {8'h0, read_data_1[7:0], 16'h0};
                        byteenable = 4'b0010;
                    end
                    2'b10: begin
                        data_writedata = {16'h0, read_data_1[7:0], 8'h0};
                        byteenable = 4'b0100;
                    end
                    2'b11: begin
                        data_writedata = {24'h0, read_data_1[7:0]};
                        byteenable = 4'b1000;
                    end
                endcase
            end
            6'b101001: begin // SH
                data_writeaddr = {alu_out[31:2], 2'b0};
                case(alu_out[1])
                    0: begin
                        data_writedata = {read_data_1[15:0], 16'h0};
                        byteenable = 4'b0011;
                    end
                    1: begin
                        data_writedata = {16'h0, read_data_1[15:0]};
                        byteenable = 4'b1100;
                    end
                endcase
            end
            6'b100011: begin // LW
                load_data = data_readdata;
                data_readaddr = alu_out;
                byteenable = 4'b1111;
            end
            6'b100000: begin // LB 
                data_readaddr = {alu_out[31:2],2'b0};

                case (alu_out[1:0])
                    2'b00: byteenable = 4'b0001;
                    2'b01: byteenable = 4'b0010;
                    2'b10: byteenable = 4'b0100;
                    2'b11: byteenable = 4'b1000;
                endcase

                case (addr_offset_prev) // assumes big endian, sign extension
                    2'b00: load_data = {{24{data_readdata[31]}},data_readdata[31:24]};
                    2'b01: load_data = {{24{data_readdata[23]}},data_readdata[23:16]};
                    2'b10: load_data = {{24{data_readdata[15]}},data_readdata[15:8]};
                    2'b11: load_data = {{24{data_readdata[7]}},data_readdata[7:0]};
                endcase
            end
            6'b100100: begin // LBU
                data_readaddr = {alu_out[31:2],2'b0};

                case (alu_out[1:0])
                    2'b00: byteenable = 4'b0001;
                    2'b01: byteenable = 4'b0010;
                    2'b10: byteenable = 4'b0100;
                    2'b11: byteenable = 4'b1000;
                endcase

                case (addr_offset_prev) // assumes big endian, zero extend
                    2'b00: load_data = {24'h0,data_readdata[31:24]};
                    2'b01: load_data = {24'h0,data_readdata[23:16]};
                    2'b10: load_data = {24'h0,data_readdata[15:8]};
                    2'b11: load_data = {24'h0,data_readdata[7:0]};
                endcase
            end
            6'b100001: begin // LH
                data_readaddr = {alu_out[31:2],2'b0};

                case (alu_out[1])
                    0: byteenable = 4'b0011;
                    1: byteenable = 4'b1100;
                endcase

                case (addr_offset_prev[1]) // assumes big endian, sign extend
                    0: load_data = {{16{data_readdata[31]}},data_readdata[31:16]};
                    1: load_data = {{16{data_readdata[15]}},data_readdata[15:0]};
                endcase
            end
            6'b100101: begin // LHU
                data_readaddr = {alu_out[31:2],2'b0};

                case (alu_out[1])
                    0: byteenable = 4'b0011;
                    1: byteenable = 4'b1100;
                endcase

                case (addr_offset_prev[1]) // assumes big endian, zero extend
                    0: load_data = {16'h0,data_readdata[31:16]};
                    1: load_data = {16'h0,data_readdata[15:0]};
                endcase
            end
            6'b100010: begin // LWL;  alu_out is most significant byte of unaligned word
                data_readaddr = {alu_out[31:2],2'b0};

                case (alu_out[1:0])
                    2'b00: byteenable = 4'b1111;
                    2'b01: byteenable = 4'b1110;
                    2'b10: byteenable = 4'b1100;
                    2'b11: byteenable = 4'b1000;
                endcase

                case(addr_offset_prev)
                    // // all bytes of readdata are valid, put all into register; essentially just LW
                    2'b00: load_data = data_readdata;
                    // last three (LSB) bytes of readdata are valid, put in MS part of register
                    2'b01: load_data = {data_readdata[23:0], read_data_1[7:0]};
                    // last two (LSB) bytes of readdata are valid, put in MS part of register
                    2'b10: load_data = {data_readdata[15:0], read_data_1[15:0]};
                    // last byte (LSB) of readdata isvalid, put in MS part of register
                    2'b11: load_data = {data_readdata[7:0], read_data_1[23:0]};
                endcase
            end
            6'b100110: begin // LWR; alu_out is least significant byte of unaligned word
                data_readaddr = {alu_out[31:2], 2'b0};

                case (alu_out[1:0])
                    2'b00: byteenable = 4'b0001;
                    2'b01: byteenable = 4'b0011;
                    2'b10: byteenable = 4'b0111;
                    2'b11: byteenable = 4'b1111;
                endcase

                case(addr_offset_prev)
                    // // first byte is valid, store in least significant part of register
                    2'b00: load_data = {read_data_1[31:8], data_readdata[31:24]};
                    // first two (MSB) bytes are valid, store in least significant part of register
                    2'b01: load_data = {read_data_1[31:16], data_readdata[31:16]};
                    // first three (MSB) bytes are valid, store in least significant part of register
                    2'b10: load_data = {read_data_1[31:24], data_readdata[31:8]};
                    // all bytes of readdata are valid, put all into register
                    2'b11: load_data = data_readdata;
                endcase            
            end
            default: begin // all other instructions (non load/store instructions)
                data_writedata = 32'hx;
                byteenable = 4'bx;
                data_writeaddr = 32'hx;
                load_data = alu_out;
                data_readaddr = 32'hx;
            end
        endcase

        if (!state) begin // to read instruction data during FETCH
            byteenable = 4'b1111;
        end
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
                write_addr = 5'd31; // $31 for all other B_link instructions
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

    assign SH = (SL | SR) & RegDst; // control signal to differentiate between LUI and shift instruction where rs and rt are swapped
    assign read_addr_0 = (SH) ? rt : rs;
    assign read_addr_1 = (SH) ? rs : rt;

    
    // regfile wen is determined by RegWrite in EXEC. In Fetch, regfile wen will only be high for load instructions(RegWrite=1) if the data from mem is valid
    logic regfile_wen;
    assign regfile_wen = (state) ? RegWrite : RegWrite & valid_data;

    regfile regfile_block(
        .clk(clk),
        .wen(regfile_wen),
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
    logic[31:0] op2, alu_out;


    always @(*) begin
        if(ALUSrc) begin
            op2 = (ShiftAmt) ? {27'b0, shamt} : // zero extension of shamt
                (Xor | And | Or) ? {16'h0000, alu_immediate} : {{16{alu_immediate[15]}}, alu_immediate};  // sign or zero extend of alu_immediate
        end else begin
            op2 = read_data_1;
        end
    end

    alu alu_block(
        .clk(clk),
        .op1(read_data_0),
        .op2(op2),
        .reset(reset),
        .Var(Var),
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