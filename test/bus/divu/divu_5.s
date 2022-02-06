// tests 4294967271/4294967291, checks for quotient of 0

.config
	ARCH v
	ASSERT 0

.text
	ADDIU $1 $0 #-25 //$1 = 0xFFFF FFE7 (sign-extended)
	ADDIU $2 $0 #-5 //$2 = 0xFFFF FFFB (sign-extended)
	DIVU $1 $2
	MFLO $2
	JR $0

.data
