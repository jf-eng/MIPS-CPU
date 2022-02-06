//testing jump and link in JALR as well as branch delay slot and JALR $0

.config
	ARCH v
	ASSERT 32'hbfc00034 
//there's always 4 instructions before
.text
  LUI $1 #0xbfc0 // address = 0xbfc00010, $1 = 0xbfc00000
  ADDIU $1 $1 #0x002c // address = 0xbfc00014, $1 = 0xbfc0002c
  JALR $3 $1 // address = 0xbfc00018, PC = 0xbfc0002c, $3 = address + 8 = 0xbfc00020
  ADDIU $2 $1 #2 // address = 0xbfc0001c, $2 = 0xbfc0002e
  ADDIU $2 $2 #2 // address = 0xbfc00020, $2 = 0xbfc00034
  JALR $4 $0 // address = 0xbfc00024
  NOP // address = 0xbfc00028
  ADDIU $2 $2 #2 // address = 0xbfc0002c, $2 = 0xbfc00030
  JR $3 // address = 0xbfc00030, PC = $3 = 0xbdc00020
  ADDIU $2 $2 #2 // address = 0xbfc00034, $2 = 0xbfc00032
  JR $0 // address = 0xbfc00038
  NOP

.data

  