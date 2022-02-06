// backwards jump

.config
	ARCH v
	ASSERT 12

.text
		J here
		NOP
	exit:
		JR $zero
	here:	
		ADDIU $t0 $zero #20
		ADDIU $t1 $zero #20
		ADDIU $v0 $zero #12
		JR $zero
		BEQ	$t0 $t1 exit
		NOP
		JR $0
		ADDIU $v0 $zero #10

.data

