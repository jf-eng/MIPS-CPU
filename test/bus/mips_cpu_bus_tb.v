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
            $readmemb(RAM_INIT_FILE, ram);
        end
    end


	// RAM READ & WRITE
    logic[31:0] ram_write_data;
    logic[7:0] ram_wordaddr;
    logic[9:0] shift_tmp;

    assign shift_tmp = address[9:0] >> 2;
    assign ram_wordaddr = shift_tmp[7:0];

    // RAM DEBUG PEAK WIRES
    logic [31:0] ram_0, ram_4, ram_8, ram_12, ram_16;
    assign ram_0 = ram[0];
    assign ram_4 = ram[1];
    assign ram_8 = ram[2];
    assign ram_12 = ram[3];
    assign ram_16 = ram[4];

    // ram write byte masks
    always @(*) begin
        case(byteenable)
            4'b0000: ram_write_data = ram[ram_wordaddr];
            4'b0001: ram_write_data = { ram[ram_wordaddr][31:8], writedata[7:0] };
            4'b0010: ram_write_data = { ram[ram_wordaddr][31:16], writedata[15:8], ram[ram_wordaddr][7:0] };
            4'b0100: ram_write_data = { ram[ram_wordaddr][31:24], writedata[23:16], ram[ram_wordaddr][15:0] };
            4'b1000: ram_write_data = { writedata[31:24], ram[ram_wordaddr][23:0] };
            4'b0011: ram_write_data = { ram[ram_wordaddr][31:16], writedata[15:0] };
            4'b1100: ram_write_data = { writedata[31:16], ram[ram_wordaddr][15:0] };
            4'b1111: ram_write_data = writedata;
            default: ram_write_data = writedata;
        endcase
    end

    always_ff @(posedge clk) begin
        // if wait request not high, can process read/write 
        if(!waitrequest) begin
            if(read) begin
                readdata <= ram[ram_wordaddr];
            end
            if(write) begin
                ram[ram_wordaddr] <= ram_write_data;
            end
        end
        // random wait signal
        waitrequest = $random();

    end

    // TESTING
    initial begin
        $monitor("Time %t:\n[RAM] PC: %h, WordADDR: %h, Instruction: %h\n[CPU] Active: %d, Register_v0 ($2): %h",
                 $time, address, ram_wordaddr, readdata, active, register_v0);

        reset = 0;
        @(negedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;

        @(negedge active); // wait until cpu ends
    end

endmodule
