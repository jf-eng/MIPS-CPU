// tests 4294963972/4294963200, checks for remainder of 772

.config
	ARCH v
	ASSERT 772

.text
	ADDIU $1 $0 #-3324 //$1 = 0xFFFF F304 (sign-extended)
	ADDIU $2 $0 #-4096 //$2 = 0xFFFF F000 (sign-extended)
	DIVU $1 $2
	MFHI $2
	JR $0

.data
