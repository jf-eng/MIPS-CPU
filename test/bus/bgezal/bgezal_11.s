// BGEZAL
.config
	ARCH v
	ASSERT 15
    
.text
    LUI $2 0x7FFF
    ADDIU $2 $2 0x7FFF
    ADDIU $2 $2 0x5000
    ADDIU $2 $2 0x3000
    BGEZAL $2 loop
    ADDIU $2 $0 0x5
    ADDIU $2 $0 #14
    JR $0
    NOP
    loop: 
        ADDIU $2 $0 #15 // $2 = 15
        NOP
    end:
    JR $0
    NOP

.data
  one #0xbfc00010
  two #10
  three #0





