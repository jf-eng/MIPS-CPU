#rd $0, rs unchanged

.config
	ARCH v
	ASSERT 32'h0

.text
		ADDIU $3 $0 #8
		ADDU $0 $5 $3
        ADDU $2 $0 $5
		JR $0

.data

