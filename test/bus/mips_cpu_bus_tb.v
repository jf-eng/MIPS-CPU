module mips_cpu_bus_tb (
	output logic active,
    output logic[31:0] register_v0
);
	
	logic clk;
    logic reset;

    /* Avalon memory mapped bus controller (master) Controls */
    logic[31:0] address;
    logic write;
    logic read;
    logic waitrequest;
    logic[31:0] writedata;
    logic[3:0] byteenable;
    logic[31:0] readdata;

	// BUS CPU
	mips_cpu_bus dut(
		.clk(clk),
		.reset(reset),
		.active(active),
		.register_v0(register_v0),
		.address(address),
		.write(write),
		.read(read),
		.waitrequest(waitrequest),
		.writedata(writedata),
		.byteenable(byteenable),
		.readdata(readdata)
	);


    // CLK
    initial begin
        $dumpfile("mips_cpu_bus_tb.vcd");
        $dumpvars(0, mips_cpu_bus_tb);
        clk = 0;
        repeat (400) begin
            #2;
            clk = !clk;
        end
        $fatal(1, "Simulation ended in 200 clock cycles");
    end

	// RAM INIT
    parameter RAM_INIT_FILE = "";
    reg [31:0] ram [0:255];

	initial begin
        for(integer i = 0; i < 255; i=i+1) begin
            ram[i] = 0;
        end
        if (RAM_INIT_FILE != "") begin
            $display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);
            $readmemh(RAM_INIT_FILE, ram);
        end
    end


	// RAM



endmodule