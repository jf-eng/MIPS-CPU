//BRANCH ON LESS THAN ZERO AND LINK

.config
  ARCH v
  ASSERT 4

.text
  ADDIU $3 $0 #0XFFFF
  SH $3 #0($gp)
  SH $3 #2($gp)
  LW $1 #0($gp)
  J jump 
  ADDIU $2 $2 #1 // $2 = 1
  ADDIU $2 $2 #1 // DON'T DO THIS
  JR $0
  NOP
  jump:
    BLTZAL $1 next_jump
  ADDIU $2 $2 #1 // $2 = 2
  ADDIU $2 $2 #1 // $2 = 4
  JR $0
  NOP
  next_jump:
    ADDIU $2 $2 #1 $2 = 3
    JR $31
.data


  