//BRANCH ON LESS THAN ZERO AND LINK - SHOULD WORK

.config
  ARCH v
  ASSERT 70

.text
  ADDIU $1 $0 #2
  ADDIU $3 $0 #4
  SUBU $1 $1 $3
  BLTZAL $1 jump
  ADDIU $2 $2 #1
  ADDIU $2 $2 #1
  JR $0
  NOP
  jump:
    ADDIU $2 $0 #69
  JR $31

.data
