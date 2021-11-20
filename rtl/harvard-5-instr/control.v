module control ( 
    input logic [5:0] instruction_opcode,
    input logic [5:0] func_code, 

    // active high control lines
    output logic RegDst, // choose rd as destination over rt
    output logic Branch, // tell pc to branch
    output logic MemRead, // reading memory
    output logic MemtoReg, // load ram_dout to regfile
    output logic MemWrite, // write to ram
    output logic ALUSrc, // change alu op2 to immediate
    output logic RegWrite, // write to register file

    output logic [5:0] ALUOp, // instruction opcode passthrough
    output logic halt
);

    assign ALUOp = instruction_opcode;
    assign halt = (instruction_opcode == 6'b111111) ? 1 : 0;

    // ADDU RegDst=1; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1;
    // JR   RegDst=X; Branch=1; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=0;


    always_comb begin
        if (instruction_opcode == 0) begin // ADDU & JR r-type instruction
            RegDst = 1;
            Branch = (func_code == 6'b001000) ? 1 : 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = (func_code == 6'b001000) ? 0 : 1;
        end
        
        else if (instruction_opcode == 6'b100011) begin // LW: opcode 0x23
            RegDst = 1;
            Branch = 0;
            MemRead = 1; // we want to read from data memory, 
            MemtoReg = 1; // pass data mem to reg
            MemWrite = 0; // we don't want to write memory
            ALUSrc = 1; // immediate offset as op2 of alu
            RegWrite = 1; // we want to write a register
        end

        else if (instruction_opcode == 6'b001001) begin // ADDIU
            RegDst = 0; 
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 1; 
            RegWrite = 1; 
        end

        else if (instruction_opcode == 6'b101011) begin // SW
            RegDst = 1;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0; // dont care
            //ALUOp = 0;
            MemWrite = 1;
            ALUSrc = 1; // immediate offset as op2 of alu
            RegWrite = 0;
        end
        
        else begin // catch all case for easy debugging
            RegDst = 1'bx;
            Branch = 1'bx;
            MemRead = 1'bx;
            MemtoReg = 1'bx;
            MemWrite = 1'bx;
            ALUSrc = 1'bx;
            RegWrite = 1'bx;
        end
    end
endmodule
        /* 
        else if (instruction_opcode == 6'b00001?) begin // J-type instruction; not needed for now 
            RegDst = 0;
            Branch = 1;
            MemRead = 0;
            MemtoReg = 0;
            //ALUOp = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
        end
        */

        // else begin // 
            // if (instruction_opcode == 6'b001100) begin // ANDI
            //     MemRead = 0;
            //     MemtoReg = 0;
            //     //ALUOp = 1;
            //     MemWrite = 0;
            //     ALUSrc = 1;
            //     RegWrite = 1;
            // end
    // end


