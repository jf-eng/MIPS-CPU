// LH
.config
	ARCH v
	ASSERT 32'hFFFFFFFF
.text
    ADDIU $2 $0 #15
    ADDIU $1 $0 #14
    SH $2 #0($gp)
    SH $1 #2($gp)
    LH $1 #0($gp)
    LH $2 #2($gp)
    SUBU $2 $2 $1
    JR $0

.data









