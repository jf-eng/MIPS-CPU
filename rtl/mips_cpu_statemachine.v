module statemachine(
    input logic clk,
    input logic reset,
    input logic stall,
    input logic active,
    output logic state
);
    logic state_next;

    always_comb begin
        if(reset) begin
            state_next = 0;
        end else if (stall | !active) begin
            state_next = state;
        end else begin
            state_next = !state;
        end
    end

    always_ff@(posedge clk) begin
        state <= state_next;
    end
endmodule