module addu_1 ();
	
    logic active;
    logic[31:0] register_v0;

    mips_cpu_harvard_tb #(
        .ROM_INIT_FILE("addu_1.rom"), // change these parameters
        .RAM_INIT_FILE("addu_1.ram") // change these parameters
    ) TB (
        .active(active),
        .register_v0(register_v0)
    );

    // TESTING
    initial begin
        @(negedge active);

        // all you need to change is this assert to the value you expect
        assert(register_v0 == 32'h12) else $fatal(1); 

        $finish;
    end

endmodule