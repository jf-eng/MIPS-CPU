module statemachine(
  input logic clk, reset,
  output logic state //STATE = 1: EXEC, STATE = 0: FETCH
);

    logic state_next;
    assign state_next = !state;

    always_ff@(posedge clk) begin
        if(reset)
            state <= 0;
        else
            state <= state_next;
    end

endmodule
