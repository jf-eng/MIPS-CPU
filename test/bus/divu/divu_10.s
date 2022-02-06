// tests 4294963972/4294963200, checks that remainder of 772 and quotient of 1 overwrites initial contents of HI and LO

.config
	ARCH v
	ASSERT 773

.text
    ADDIU $3 $0 #78
    ADDIU $4 $0 #62
    MTHI $3
    MTLO $4
	ADDIU $1 $0 #-3324 //$1 = 0xFFFF F304 (sign-extended)
	ADDIU $2 $0 #-4096 //$2 = 0xFFFF F000 (sign-extended)
	DIVU $1 $2
	MFHI $2
    MFLO $3
    ADDU $2 $2 $3
	JR $0

.data
