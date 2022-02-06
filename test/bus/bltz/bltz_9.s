// eq to 0

.config
	ARCH v
	ASSERT 32'hf

.text
		J loop3 //1
	loop:
		ADDIU $2 $0 #0xFFFF //3
		J loop2
		ADDIU $0 $0 #0
	loop3:
		LUI $2 0x7FFF //2
		ADDIU $2 $2 0x7FFF
		ADDIU $2 $2 0x5000
		ADDIU $2 $2 0x3000
		BLTZ $2 loop
		ADDIU $2 $0 #0x10
		ADDIU $2 $0 #0xF
		JR $0
		NOP
		NOP
	loop2:
		ADDIU $3 $0 #10 //4
		ADDIU $2 $0 #14
		JR $0
		NOP
.data
	one #0



