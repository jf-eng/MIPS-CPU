module control ( 
    input logic [5:0] instruction_opcode,
    input logic [5:0] func_code,

    output logic RegDst, // choose rd as destination over rt
    output logic Branch, // tell pc to branch
    output logic MemRead, // reading memory
    output logic MemtoReg, // load ram_dout to regfile
    output logic MemWrite, // write to ram
    output logic ALUSrc, // change alu op2 to immediate
    output logic RegWrite, // write to register file

    output logic [5:0] ALUOp,
    output logic halt
);

    assign ALUOp = instruction_opcode;
    assign halt = (instruction_opcode == 6'b111111) ? 1 : 0;


    always_comb begin
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
            else if (instruction_opcode == 6'h23) begin // LW
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
    // OLD CODE:



