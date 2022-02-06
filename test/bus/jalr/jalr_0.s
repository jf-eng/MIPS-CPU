//testing jump in JALR as well as rd in branch delay slot

.config
	ARCH v
	ASSERT 32'hbfc00028 
//there's always 4 instructions before
.text
  LUI $1 #0xbfc0 // address = 0xbfc00010, $1 = 0xbfc00000
  ADDIU $1 $1 #0x0024 // address = 0xbfc00014, $1 = 0xbfc00024
  JALR $2 $1 // address = 0xbfc00018, PC = 0xbfc00024, $2 = address + 8 = 0xbfc00020
  ADDIU $2 $1 #2 // address = 0xbfc0001c, $2 = 0xbfc00026
  ADDIU $2 $2 #2 // IGNORED, address = 0xbfc00020
  ADDIU $2 $2 #2 // address = 0xbfc00024, $2 = 0xbfc00028
  JR $0 // address = 0xbfc00028
  NOP

.data

  