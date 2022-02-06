// eq to 0

.config
	ARCH v
	ASSERT 32'he

.text
		ADDIU $2 $0 #1
		BLEZ $2 loop
		ADDIU $3 $0 #10
		ADDIU $2 $0 #14
		JR $0
		NOP
	loop:
		ADDIU $2 $0 #15
		NOP
	end:
		JR $0
		NOP
.data
	one #0



