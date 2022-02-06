// eq to 0

.config
	ARCH v
	ASSERT 32'he

.text
		J loop3 //1
	loop:
		ADDIU $2 $0 #0xFFFF //3
		J loop2
		ADDIU $0 $0 #0
	loop3:
		ADDIU $2 $0 #0xFFFF //2
		BLTZ $2 loop
		ADDIU $2 $0 #15
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



