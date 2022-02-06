//rd $0

.config
	ARCH v
	ASSERT 32'h0

.text
	ADDIU $2 $0 #0xFFFF
	ADDIU $3 $0 #0xFFFF
	AND $0 $2 $3
    AND $2 $2 $0
	JR $0

.data
