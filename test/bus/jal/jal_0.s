.config
	ARCH v
	ASSERT 2

.text
	JAL jmp 
	ADDIU $2 $2 #1 // $2 = 1
exit:
	JR $0
	NOP
jmp:
	ADDIU $2 $2 #1 // $2 = 2
	JR $31

.data
	