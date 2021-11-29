
module jalr_0 ();
	
    logic active;
    logic[31:0] register_v0;

    mips_cpu_harvard_tb #(
        .ROM_INIT_FILE("jalr_0.rom"),
        .RAM_INIT_FILE("jalr_0.ram")
    ) TB (
        .active(active),
        .register_v0(register_v0)
    );

    initial begin
        @(negedge active);
        assert(register_v0 == 32'hbfc00014) else $fatal(1); 
        $finish;
    end

endmodule
