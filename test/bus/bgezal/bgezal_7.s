// BGEZAL
.config
	ARCH v
	ASSERT 32'hFFFFFFF9 
    
.text
    ADDIU $4 $0 #0XBFC0
    SH $4 #0($gp)
    ADDIU $4 $0 #0X10
    SH $4 #2($gp)
    ADDIU $1 $0 #16 // $1 = 16: pc = 0
    ADDIU $2 $0 #0x1 // $2 = 1
    ADDIU $3 $0 #15 // $3 = 15
    ADDIU $3 $0 #10
    SUBU $2 $2 $3
    BGEZAL $2 loop // $2 if $2 >=0 go to loop -> executed
    ADDIU $2 $2 #2 // $2 = -7
    JR $0
    NOP
    loop:
        ADDIU $2 $0 #15 // $2 = 15
        NOP 
    end:
    JR $0
    NOP

.data





