/* 
    This module decides whether a branch/jump should be executed or not.
    Branch goes high if PC should branch
    By JF
*/

module branch_control(
    input logic N, Z, // flags for negative, zero alu output
    input logic op_code,
    output logic Branch
);

endmodule