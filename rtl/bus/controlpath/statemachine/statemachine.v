module statemachine(
    input logic clk,
    input logic reset,
    input logic stall,
    output logic state
);
    logic state_next;
    assign state_next = (stall) ? state : !state;

    always_ff@(posedge clk) begin
        if(reset) begin
            state <= 0;
        end else begin
            state <= state_next;
        end
    end
endmodule