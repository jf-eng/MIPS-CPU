// SLTIU is sign extended then treated as unsigned

.config
	ARCH v
	ASSERT 1

.text
	ADDIU $3 $0 #0x0fff
	SH $3 #0($gp)
	ADDIU $3 $0 #0xaaaa
	SH $3 #2($gp)
	LW $1 #0($gp)
	JR $0
	SLTIU $2 $1 #0xFFFF // $1 is less than 0xFFFF since 0xFFFF is sign extended

.data

	