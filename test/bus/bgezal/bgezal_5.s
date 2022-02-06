// BGEZAL

.config
	ARCH v
	ASSERT 32'h00000005
.text
    ADDIU $4 $0 #0XBFC0
    SH $4 #0($gp)
    ADDIU $4 $0 #0X10
    SH $4 #2($gp)
    ADDIU $1 $0 #16 // $1 = 16: pc = 0
    ADDIU $2 $0 #0x1 // $2 = 1
    ADDIU $3 $0 #15 // $3 = 15
    ADDIU $3 $0 #1 // $3 = 1
    ADDU $2 $2 $3 // $2 = 2
    BGEZAL $2 loop // $2 if $2 >=0 go to loop -> executed
    ADDU $2 $2 $3 // $2 = 3
    ADDIU $2 $0 #5 // $2 = 5
    JR $0
    NOP
    loop:
        ADDIU $2 $0 #15 // $
        JR $31
        NOP
        
    end:
    JR $0
    NOP
.data







