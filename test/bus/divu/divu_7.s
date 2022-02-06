// tests 4294963972/4294963200, checks for quotient of 1

.config
	ARCH v
	ASSERT 1

.text
	ADDIU $1 $0 #-3324 //$1 = 0xFFFF F304 (sign-extended)
	ADDIU $2 $0 #-4096 //$2 = 0xFFFF F000 (sign-extended)
	DIVU $1 $2
	MFLO $2
	JR $0

.data
