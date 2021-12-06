
module test1 ();
	
    logic active;
    logic[31:0] register_v0;

    mips_cpu_bus_tb #(
        .RAM_INIT_FILE("test1.ram")
    ) TB (
        .active(active),
        .register_v0(register_v0)
    );

    initial begin
        @(negedge active);
        assert(register_v0 == 1) else $fatal(1); 
        $finish;
    end

endmodule
