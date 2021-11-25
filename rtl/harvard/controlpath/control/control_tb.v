module control_tb();

    logic [5:0] instruction_opcode;
    logic [5:0] func_code; 
    logic [4:0] special_branch_codes;
    logic state;
    logic B_link;
    logic RegDst;
    logic MemRead;
    logic MemtoReg;
    logic MemWrite;
    logic ALUSrc;
    logic RegWrite;
    logic Add;
    logic Sub;
    logic Mul;
    logic Div;
    logic Unsigned;
    logic Or;
    logic And;
    logic Xor;
    logic SL;
    logic SR;
    logic Arithmetic;
    logic Boolean;
    logic R31;
    logic ShiftAmt;
    logic [5:0] counter;
    
    control dut(

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

    initial begin
        instruction_opcode = 0;
        func_code = 0;
        special_branch_codes = 0;
        counter = 0;
        state = 1;
        B_link = 1;
    end
    //assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
    initial begin
        func_code = 6'b100001; // ADDIU
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 1 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 1 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b100100; // AND
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 1 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b011010; // DIV
        #1;
        assert(/*RegDst == 1'bx &&*/ MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 1 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b011011; // DIVU
        #1;
        assert(/*RegDst == 1'bx &&*/ MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 1 && Unsigned == 1 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b001001; // JALR
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == B_link && ShiftAmt == 0 && R31 == 1 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b001000; // JR
        #1;
        assert(/*RegDst == 1'bx &&*/ MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b010001; // MTHI
        #1;
        assert(/*RegDst == 1'bx &&*/ MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b010011; // MTLO
        #1;
        assert(/*RegDst == 1'bx &&*/ MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b011000; //MULT
        #1;
        assert(/*RegDst == 1'bx &&*/ MemRead == 0 && /*MemtoReg == 1'bx &&*/ MemWrite == 0 && ALUSrc == 0 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 1 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b011001; // MULTU
        #1;
        assert(/*RegDst == 1'bx &&*/ MemRead == 0 && /*MemtoReg == 1'bx &&*/ MemWrite == 0 && ALUSrc == 0 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 1 && Div == 0 && Unsigned == 1 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b100101; // OR
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 1 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b000000; // SLL
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 1 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 1 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b000100; // SLLV
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 1 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b101010; //SLT
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 1);
        func_code = 6'b101011; //SLTU
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 1 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 1);
        func_code = 6'b000011; //SRA
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 1 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 1 && Arithmetic == 1 && Boolean == 0);
        func_code = 6'b000111; //SRAV
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 1 && Arithmetic == 1 && Boolean == 0);
        func_code = 6'b000010; //SRL
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 1 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 1 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b000110; //SRLV
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 1 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b100011; //SUBU
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 1 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        func_code = 6'b100110; //XOR
        #1;
        assert(RegDst == 1 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 1 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b000001;
        special_branch_codes = 5'b00001; // BGEZ
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        special_branch_codes = 5'b10001; // BGEZAL
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 1 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        special_branch_codes = 5'b00000; // BLTZ
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        special_branch_codes = 5'b10000; // BLTZAL
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 1 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b000010; // J
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b000011; // JAL
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 0 && RegWrite == B_link && ShiftAmt == 0 && R31 == 1 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b000100; // BEQ
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b000101; // BNE
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b000110; // BLEZ
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b000111; // BGTZ
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == B_link && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b001001; // ADDIU
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 1 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 1 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b001010; // SLTI
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 1);
        instruction_opcode = 6'b001011; // SLTIU
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 1 && Mul == 0 && Div == 0 && Unsigned == 1 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 1);
        instruction_opcode = 6'b001100; // ANDI
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 1 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b001101; // ORI
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 1 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b001110; // XORI
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 1 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b001111; // LUI
        #1;
        assert(RegDst == 0 && MemRead == 0 && MemtoReg == 0 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 0 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 1 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b100011; // LW
        #1;
        assert(RegDst == 0 && MemRead == 1 && MemtoReg == 1 && MemWrite == 0 && ALUSrc == 1 && RegWrite == 1 && ShiftAmt == 0 && R31 == 0 && Add == 1 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
        instruction_opcode = 6'b101011; // SW
        #1;
        assert(/*RegDst == 0 &&*/ MemRead == 0 /*&& MemtoReg == 0*/ && MemWrite == 1 && ALUSrc == 1 && RegWrite == 0 && ShiftAmt == 0 && R31 == 0 && Add == 1 && Sub == 0 && Mul == 0 && Div == 0 && Unsigned == 0 && Or == 0 && And == 0 && Xor == 0 && SL == 0 && SR == 0 && Arithmetic == 0 && Boolean == 0);
    end
endmodule