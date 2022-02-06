// backwards jump

.config
	ARCH v
	ASSERT 12

.text
		ADDIU $2 $0 #15
		ADDIU $3 $0 #15
		BEQ $2 $3 loop
		ADDIU $2 $2 #2
		JR $0
		NOP
		loop:
		ADDIU $2 $0 #12
		JR $0
		end:

.data





