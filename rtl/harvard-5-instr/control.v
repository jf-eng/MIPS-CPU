module control ( 
    input logic [5:0] instruction_opcode,
    input logic [5:0] func_code,
    output logic RegDst,
    output logic Branch,
    output logic MemRead,
    output logic MemtoReg,
    output logic [5:0] ALUOp,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite
);

    always_comb begin
        ALUOp = instruction_opcode;
        if (instruction_opcode == 0) begin
            RegDst = 1;
            Branch = (func_code == 6'b001000) ? 1 : 0;
            MemRead = 0;
            MemtoReg = 0;
            //ALUOp = 1;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;
        end
        else if (instruction_opcode == 6'b00001?) begin
            RegDst = 0;
            Branch = 1;
            MemRead = 0;
            MemtoReg = 0;
            //ALUOp = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;

        end
        else begin
            RegDst = 1;
            Branch = 0;
            if (instruction_opcode == 12) begin
                MemRead = 0;
                MemtoReg = 0;
                //ALUOp = 1;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
            else if (instruction_opcode == 6'h23) begin
                MemRead = 1;
                MemtoReg = 1;
                //ALUOp = 1;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                
            end
            else begin
                MemRead = 0;
                MemtoReg = 0;
                // = 1;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 0;
            end
        end
        
    end
endmodule
