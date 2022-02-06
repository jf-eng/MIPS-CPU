// tests that rs remains the same after divu op

.config
	ARCH v
	ASSERT 4294963972

.text
	ADDIU $1 $0 #-3324 //$1 = 0xFFFF F304 (sign-extended)
	ADDIU $2 $0 #-4096 //$2 = 0xFFFF F000 (sign-extended)
	DIVU $1 $2
	ADDIU $2 $1 #0
	JR $0

.data
