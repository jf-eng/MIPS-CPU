// BGEZAL
.config
	ARCH v
	ASSERT 15
    
.text
    ADDIU $2 $0 #0x1
    BGTZ $2 loop
    ADDIU $2 $2 0xFFFF
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


