.config
	ARCH v
	ASSERT 1

.text
	ADDIU $1 $0 #0xF000
  ADDIU $3 $0 #0xFFFE
  SLT $2 $1 $3
  JR $0
.data
