//BRANCH ON LESS THAN ZERO AND LINK - SHOULDN'T WORK

.config
  ARCH v
  ASSERT 0

.text
  ADDIU $1 $0 #2
  ADDIU $3 $0 #4
  ADDU $1 $1 $3
  BLTZAL $2 jump
  ADDIU $1 $1 #0
  JR $0
  NOP
  jump:
    ADDIU $2 $0 #69
  JR $31

.data
