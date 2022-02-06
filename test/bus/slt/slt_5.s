// postive compared with negative

.config
	ARCH v
	ASSERT 1

.text
	ADDIU $1 $0 #0xFFFF
  ADDIU $3 $0 #0x1
  SLT $2 $1 $3
  JR $0
.data
