.config
	ARCH v
	ASSERT 0

.text
	ADDIU $1 $0 #0xFFFF
  ADDIU $3 $0 #0xFFFE
  SLT $2 $1 $3
  JR $0
.data
