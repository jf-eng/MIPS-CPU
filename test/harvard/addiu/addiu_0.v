module addiu_0 ();
	
    logic active;
    logic[31:0] register_v0;

    mips_cpu_harvard_tb #(
        .ROM_INIT_FILE("addiu_0.rom"), // change these parameters
        .RAM_INIT_FILE("addiu_0.ram") // change these parameters
    ) TB (
        .active(active),
        .register_v0(register_v0)
    );

    // TESTING
    initial begin
        @(negedge active);

        // all you need to change is this assert to the value you expect
        assert(register_v0 == 24) else $fatal(1); 

        $finish;
    end

endmodule