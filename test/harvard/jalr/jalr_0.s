.config
	ARCH h
	ASSERT 32'hbfc00014

.text
	LW $1 #0($0) // $1 = 16: pc = 0
  JALR $2 $1 // $2 = 0x4, pc = 0x10: pc = 4
  ADDIU $2 $1 #2 // $2 = 0x12: pc = 8
  ADDIU $2 $2 #2 // IGNORED
  ADDIU $2 $2 #2 // $2 = 0x14
  JR $0
  NOP

.data
  #0xbfc00010
  