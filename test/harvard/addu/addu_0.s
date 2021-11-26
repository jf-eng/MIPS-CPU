.config
	ARCH h // meaning harvard, v for von neumann

.text
		ADDIU $2 $0 #0x10
		ADDIU $3 $0 #1
	loop:
		ADDU $0 $0 $0 // this line is where "loop" points to
		BGTZ $2 loop // can reference labels for branch & jump instructions
		SUBU $2 $2 $3
	end:
		JR $0

.data
		#1 // data can only be integers as of now
		#0x1234
		#0b10101


	// harvard
	// addu_0.rom
	// addu_0.ram

	// von N
	// addu_0.ram