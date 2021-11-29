//BRANCH ON LESS THAN ZERO AND LINK - SHOULD WORK

.config
  ARCH h
  ASSERT 69

.text
  ADDIU $1 $0 #2
  ADDIU $3 $0 #4
  SUBU $1 $1 $3
  BLTZAL $1 jump
  ADDIU $2 $2 #1
  JR $0
  jump:
    ADDIU $2 $0 #69
  JR $31

.data
