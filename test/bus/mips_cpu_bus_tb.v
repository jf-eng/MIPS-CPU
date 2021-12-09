module mips_cpu_bus_tb (
	output logic active,
    output logic[31:0] register_v0
);
	
    parameter RAM_SIZE_WORDS = 256;

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
        repeat (2000) begin
            #2;
            clk = !clk;
        end
        $fatal(1, "Simulation ended in 1000 clock cycles");
    end

    // WAIT SIGNAL INIT
    parameter WAIT_REQUEST_TYPE = 1;
    initial begin
        case (WAIT_REQUEST_TYPE)
            0: waitrequest = 0; // nowait
            1: waitrequest = 0; // wait_random
            2: waitrequest = 0; // wait_flipped
            3: waitrequest = 1; // wait_flipped
        endcase
    end
    always_ff @(posedge clk) begin
        case (WAIT_REQUEST_TYPE)
            1: waitrequest = $urandom();
            2 || 3: waitrequest = !waitrequest;
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
            {ram[4*i], ram[4*i+1], ram[4*i+2], ram[4*i+3]} = ram_tmp[i];
        end
    end

	// RAM READ & WRITE
    logic[31:0] ram_write_data;
    logic[9:0] ram_byte_aligned_addr;

    assign ram_byte_aligned_addr = (address >= 32'hBFC00000 && address <= 32'hBFC00000 + ((RAM_SIZE_WORDS-1) * 4)) ? address[9:0] : 9'hx;

    always_ff @(posedge clk) begin
        // if wait request not high, can process read/write 
        if(!waitrequest) begin
            if(read) begin
                // readdata <= readdata_next;
                readdata[31:24] <= byteenable[0] ? ram[ram_byte_aligned_addr] : 8'hx;
                readdata[23:16] <= byteenable[1] ? ram[ram_byte_aligned_addr+1] : 8'hx;
                readdata[15:8] <= byteenable[2] ? ram[ram_byte_aligned_addr+2] : 8'hx;
                readdata[7:0] <= byteenable[3] ? ram[ram_byte_aligned_addr+3] : 8'hx;
            end
            if(write) begin
                ram[ram_byte_aligned_addr] <= byteenable[0] ? writedata[31:24] : ram[ram_byte_aligned_addr];
                ram[ram_byte_aligned_addr + 1] <= byteenable[1] ? writedata[23:16] : ram[ram_byte_aligned_addr + 1];
                ram[ram_byte_aligned_addr + 2] <= byteenable[2] ? writedata[15:8] : ram[ram_byte_aligned_addr + 2];
                ram[ram_byte_aligned_addr + 3] <= byteenable[3] ? writedata[7:0] : ram[ram_byte_aligned_addr + 3];
                // ram[ram_byte_aligned_addr] <= byteenable[0] ? writedata[7:0] : ram[ram_byte_aligned_addr];
                // ram[ram_byte_aligned_addr + 1] <= byteenable[1] ? writedata[15:8] : ram[ram_byte_aligned_addr + 1];
                // ram[ram_byte_aligned_addr + 2] <= byteenable[2] ? writedata[23:16] : ram[ram_byte_aligned_addr + 2];
                // ram[ram_byte_aligned_addr + 3] <= byteenable[3] ? writedata[31:24] : ram[ram_byte_aligned_addr + 3];


            end
        end
    end

    // TESTING
    initial begin
        // $monitor("Time %t:\n[RAM] ADDR: %h, WordADDR: %h, Data: %h\n[CPU] Active: %d, Register_v0 ($2): %h",
        //          $time, address, ram_byte_aligned_addr, readdata, active, register_v0);
            $monitor("Clock: %b, Waitrequest: %b", clk, waitrequest );
        reset = 0;
        @(negedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;

        @(negedge active); // wait until cpu ends
    end

endmodule
