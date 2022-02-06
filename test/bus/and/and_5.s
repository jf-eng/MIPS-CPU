//rs unchanged

.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $1 $0 #0xFFFF
	AND $2 $1 $0
    ADDU $2 $1 $0
	JR $0

.data
