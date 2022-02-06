// BGEZAL
.config
	ARCH v
	ASSERT 32'hf
    
.text
    ADDIU $2 $0 #0
    BGEZAL $2 loop
    ADDIU $2 $0 0xFFFF
    ADDIU $2 $0 #14
    JR $0
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





