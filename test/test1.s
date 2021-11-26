.config
	ARCH h

.text
		ADDIU $2 $0 #0x10
		ADDIU $3 $0 #1
	loop:
		ADDU $0 $0 $0
		BGTZ $2 loop
		SUBU $2 $2 $3
	end:
		JR $0

.data
		#1
		#0x1234
		#0x0ff00ff0
