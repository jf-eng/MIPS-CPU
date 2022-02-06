module mips_cpu_bus_tb (
	output logic active,
    output logic[31:0] register_v0
);
	
    parameter RAM_SIZE_WORDS = 256;
    parameter CLK_CYCLES = 20000;

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
        // $dumpfile("mips_cpu_bus_tb.vcd");
        // $dumpvars(0, mips_cpu_bus_tb);
        clk = 0;
        repeat (CLK_CYCLES * 2) begin
            #2;
            clk = !clk;
        end
        $fatal(1, "Simulation timed out.");
    end

    // WAIT SIGNAL INIT
    parameter WAIT_REQUEST_TYPE = 1;
    initial begin
        case (WAIT_REQUEST_TYPE)
            0: waitrequest = 0; // nowait
            1: waitrequest = 0; // wait_random
            2: waitrequest = 0; // wait_flipped
            3: waitrequest = 1; // wait_flipped_reverse
        endcase
    end

	// RAM INIT
    parameter RAM_INIT_FILE = "";
    reg [31:0] ram_tmp [0:RAM_SIZE_WORDS-1];
    reg [7:0] ram [0:RAM_SIZE_WORDS*4-1]; // we have 1024 bytes

	initial begin
        for(integer i = 0; i < RAM_SIZE_WORDS; i=i+1) begin
            ram_tmp[i] = 0;
        end
        if (RAM_INIT_FILE != "") begin
            $display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);
            $readmemb(RAM_INIT_FILE, ram_tmp);
        end

        // transfer from ram_word_addr into ram in byte address
        for(integer i = 0; i < RAM_SIZE_WORDS; i=i+1) begin
            {ram[4*i+0], ram[4*i+1], ram[4*i+2], ram[4*i+3]} = ram_tmp[i];
        end
    end

	// RAM READ & WRITE
    always @(negedge clk) begin
        if(reset && (read || write)) begin
            $fatal(2, "Attempted to read/write during reset."); 
        end
        if((!valid_addr) && (read || write)) begin
            $fatal(2, "Attempted to read/write outside of initialised ram.");
        end
    end

    logic[9:0] ram_byte_aligned_addr;

    logic valid_addr;
    assign valid_addr = (address >= 32'hBFC00000 && address <= 32'hBFC00000 + ((RAM_SIZE_WORDS-1) * 4));

    assign ram_byte_aligned_addr = valid_addr ? address[9:0] : 9'hx;

    always_ff @(posedge clk) begin
        // if wait request not high, can process read/write 
        if(!waitrequest) begin
            if(read) begin
                readdata[7:0] <= byteenable[0] ? ram[ram_byte_aligned_addr] : 8'hx;
                readdata[15:8] <= byteenable[1] ? ram[ram_byte_aligned_addr+1] : 8'hx;
                readdata[23:16] <= byteenable[2] ? ram[ram_byte_aligned_addr+2] : 8'hx;
                readdata[31:24] <= byteenable[3] ? ram[ram_byte_aligned_addr+3] : 8'hx;
            end
            if(write) begin
                ram[ram_byte_aligned_addr] <= byteenable[0] ? writedata[7:0] : ram[ram_byte_aligned_addr];
                ram[ram_byte_aligned_addr + 1] <= byteenable[1] ? writedata[15:8] : ram[ram_byte_aligned_addr + 1];
                ram[ram_byte_aligned_addr + 2] <= byteenable[2] ? writedata[23:16] : ram[ram_byte_aligned_addr + 2];
                ram[ram_byte_aligned_addr + 3] <= byteenable[3] ? writedata[31:24] : ram[ram_byte_aligned_addr + 3];
            end
        end
        
        case (WAIT_REQUEST_TYPE)
            1: waitrequest <= $urandom();
            2: waitrequest <= !waitrequest;
            3: waitrequest <= !waitrequest;
        endcase
    end

    // TESTING
    initial begin
        reset <= 0;
        @(posedge clk);
        reset <= 1;
        @(posedge clk);
        reset <= 0;
    end

endmodule
