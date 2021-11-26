.config
	ARCH h

.text
		ADDIU $2 $0 #0x10
		ADDIU $3 $0 #2
		ADDU $2 $2 $3
		JR $0

.data
