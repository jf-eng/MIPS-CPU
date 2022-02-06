.config
	ARCH v
	ASSERT 32'h00000002

.text
  ADDIU $4 $0 #0XBFC0
  SH $4 #0($gp)
  ADDIU $4 $0 #0X10
  SH $4 #2($gp)
  LW $1 #0($gp) // $1 = 16: pc = 0
  ADDIU $2 $0 #0x1 // $2 = 1
  ADDIU $3 $0 #15 // $3 = 15
  SW $2 #4($gp) 
  LW $3 #4($gp) // $3 = 1
  ADDU $2 $2 $3
  JR $0
  NOP

.data
  







  