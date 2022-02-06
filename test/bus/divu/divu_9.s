// tests 4294963200/4294963200, checks for quotient of 1, tests same reg also

.config
	ARCH v
	ASSERT 1

.text
	ADDIU $2 $0 #-4096 //$2 = 0xFFFF F000 (sign-extended)
	DIVU $2 $2
	MFLO $2
	JR $0

.data
