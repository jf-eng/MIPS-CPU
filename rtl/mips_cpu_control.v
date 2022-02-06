module control (
    input logic [5:0] instruction_opcode,
    input logic [5:0] func_code, 
    input logic [4:0] special_branch_codes,
    input logic state,
    input logic B_link,
    input logic active,
    input logic reset,
    input logic [31:0] address,
    // active high control lines
    output logic RegDst, // choose rd as destination over rt
    output logic MemRead, // reading memory
    output logic MemtoReg, // load ram_dout to regfile
    output logic MemWrite, // write to ram
    output logic ALUSrc, // change alu op2 to immediate
    output logic RegWrite, // write to register file
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
    output logic WriteLo,
    output logic WriteHi,
    output logic ReadLo,
    output logic ReadHi,
    output logic LUI,
    output logic Var
);  

    always @(*) begin
        if (!active | reset) begin
            RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
            Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0;
        end

        else if (!state) begin
            if(instruction_opcode[5:3] == 3'b100) begin // if load instruction
                if (address != 32'h0) begin
                    RegDst = 0; MemRead = 1; MemtoReg = 1; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0;
                end else begin
                    RegDst = 0; MemRead = 0; MemtoReg = 1; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0;
                end
            end else begin
                if (address != 32'h0) begin
                    RegDst = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0;
                end else begin
                    RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0;
                end
            end
        end
        
        else begin // if EXEC
            if (instruction_opcode == 0) begin
                casex  (func_code)
                    6'b100001 : begin // ADDU
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100100 : begin // AND
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 1; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b011010 : begin // DIV
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 1; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b011011 : begin // DIVU
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 1; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b001001 : begin //JALR
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b001000 : begin // JR
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b010001 : begin // MTHI
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 1; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b010011 : begin // MTLO
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 1; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b011000 : begin // MULT
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 1'bx; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 1; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b011001 : begin // MULTU
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 1'bx; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 1; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100101 : begin // OR
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 1; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b000000 : begin // SLL
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 1; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 1; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b000100 : begin // SLLV
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 1;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 1; SR = 0; Arithmetic = 0; Boolean = 0;  WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b101010 : begin // SLT
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 1; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b101011 : begin // SLTU
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 1; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b000011 : begin // SRA
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 1; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 1; Arithmetic = 1; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b000111 : begin // SRAV
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 1;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 1; Arithmetic = 1; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b000010 : begin // SRL
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 1; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 1; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b000110 : begin // SRLV
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 1;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 1; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100011 : begin // SUBU
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100110 : begin // XOR
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 1; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b010000 : begin // MFHI
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 1; LUI = 0; end
                    6'b010010 : begin // MFLO
                        RegDst = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 1; ReadHi = 0; LUI = 0; end
                    default : begin
                        RegDst = 1'bx; MemRead = 1'bx; MemtoReg = 1'bx; MemWrite = 1'bx; ALUSrc = 1'bx; RegWrite = 1'bx; ShiftAmt = 1'bx; Var = 1'bx;
                        Add = 1'bx; Sub = 1'bx; Mul = 1'bx; Div = 1'bx; Unsigned = 1'bx; Or = 1'bx; And = 1'bx; Xor = 1'bx; SL = 1'bx; SR = 1'bx; Arithmetic = 1'bx; Boolean = 1'bx; WriteLo = 1'bx; WriteHi = 1'bx; ReadLo = 1'bx; ReadHi = 1'bx; LUI = 1'bx;end  
                endcase
            end
            
            else if (instruction_opcode == 6'b000001) begin // special branches using rt
                casex(special_branch_codes)
                    5'b00001 : begin // BGEZ(Is offset*4 done by SL or Mul?)
                    RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    5'b10001 : begin // BGEZAL
                    RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    5'b00000 : begin // BLTZ
                    RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    5'b10000 : begin // BLTZAL
                    RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                    Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    default : begin
                        RegDst = 1'bx; MemRead = 1'bx; MemtoReg = 1'bx; MemWrite = 1'bx; ALUSrc = 1'bx; RegWrite = 1'bx; ShiftAmt = 1'bx; Var = 1'bx;
                        Add = 1'bx; Sub = 1'bx; Mul = 1'bx; Div = 1'bx; Unsigned = 1'bx; Or = 1'bx; And = 1'bx; Xor = 1'bx; SL = 1'bx; SR = 1'bx; Arithmetic = 1'bx; Boolean = 1'bx; WriteLo = 1'bx; WriteHi = 1'bx; ReadLo = 1'bx; ReadHi = 1'bx; LUI = 1'bx;end  
                endcase
            end
            else begin
                casex(instruction_opcode)
                    6'b000010 : begin // J
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    
                    6'b000011 : begin // JAL
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b000100 : begin // BEQ
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b000101 : begin // BNE
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b000110 : begin // BLEZ
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b000111 : begin // BGTZ
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = B_link; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b001001 : begin // ADDIU
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b001010 : begin // SLTI
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 1; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b001011 : begin // SLTIU
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 1; Mul = 0; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 1; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b001100 : begin // ANDI
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 1; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b001101 : begin // ORI
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 1; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b001110 : begin // XORI
                        RegDst = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 1; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b001111 : begin // LUI
                        RegDst = 0; MemRead = 0; MemtoReg = 1; MemWrite = 0; ALUSrc = 1; RegWrite = 1; ShiftAmt = 0; Var = 0;
                        Add = 0; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 1; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 1; end
                
                    6'b100011 : begin // LW
                        RegDst = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                
                    6'b101011 : begin // SW
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 1'bx; MemWrite = 1; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100000 : begin // LB
                        RegDst = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100001 : begin // LH
                        RegDst = 0; MemRead = 1; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100010 : begin // LWL
                        RegDst = 0; MemRead = 1; MemtoReg = 1; MemWrite = 0; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100100 : begin // LBU
                        RegDst = 0; MemRead = 1; MemtoReg = 1; MemWrite = 0; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100101 : begin // LHU
                        RegDst = 0; MemRead = 1; MemtoReg = 1; MemWrite = 0; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 1; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b100110 : begin // LWR
                        RegDst = 0; MemRead = 1; MemtoReg = 1; MemWrite = 0; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b101000 : begin //SB
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 1'bx; MemWrite = 1; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    6'b101001 : begin //SH
                        RegDst = 1'bx; MemRead = 0; MemtoReg = 1'bx; MemWrite = 1; ALUSrc = 1; RegWrite = 0; ShiftAmt = 0; Var = 0;
                        Add = 1; Sub = 0; Mul = 0; Div = 0; Unsigned = 0; Or = 0; And = 0; Xor = 0; SL = 0; SR = 0; Arithmetic = 0; Boolean = 0; WriteLo = 0; WriteHi = 0; ReadLo = 0; ReadHi = 0; LUI = 0; end
                    default : begin
                        RegDst = 1'bx; MemRead = 1'bx; MemtoReg = 1'bx; MemWrite = 1'bx; ALUSrc = 1'bx; RegWrite = 1'bx; ShiftAmt = 1'bx; Var = 1'bx;
                        Add = 1'bx; Sub = 1'bx; Mul = 1'bx; Div = 1'bx; Unsigned = 1'bx; Or = 1'bx; And = 1'bx; Xor = 1'bx; SL = 1'bx; SR = 1'bx; Arithmetic = 1'bx; Boolean = 1'bx; WriteLo = 1'bx; WriteHi = 1'bx; ReadLo = 1'bx; ReadHi = 1'bx; LUI = 1'bx;end  
                endcase
            end
        end        
    end
endmodule