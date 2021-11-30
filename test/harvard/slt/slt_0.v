
module slt_0 ();
	
    logic active;
    logic[31:0] register_v0;

    mips_cpu_harvard_tb #(
        .ROM_INIT_FILE("slt_0.rom"),
        .RAM_INIT_FILE("slt_0.ram")
    ) TB (
        .active(active),
        .register_v0(register_v0)
    );

    initial begin
        @(negedge active);
        assert(register_v0 == 0) else $fatal(1); 
        $finish;
    end

endmodule
