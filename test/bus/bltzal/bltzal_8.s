// store link with false branch

.config
	ARCH v
	ASSERT 32'hBFC0001D


.text
		ADDIU $t0 $t0 #1
		BLTZAL $t0 here
		ADDIU $v0 $ra #0
		ADDIU $v0 $v0 #1
	here:	
		JR $zero

.data

