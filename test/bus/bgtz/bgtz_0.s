//BRANCH ON GREATER THAN ZERO - SHOULD WORK

.config
  ARCH v
  ASSERT 70

.text
  ADDIU $1 $0 #2 // $1 = 2
  BGTZ $1 jump // if $1 > 0, jump
  ADDIU $2 $2 #1 // $2 = 1
  JR $0
  ADDIU $2 $2 #1
  JR $0
  jump:
    ADDIU $2 $2 #68 //$2 = 68
  ADDIU $2 $2 #1
  JR $0
  

.data
