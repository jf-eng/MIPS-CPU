// SB
.config
	ARCH v
	ASSERT 32'h1
    
.text
    
    ADDIU $2 $0 #2     //0
    ADDIU $1 $0 #1   //4
    NOP //  //8
    SB $1 #3($gp)   //12
    NOP //  //16
    LW $2 #0($gp)   //20
    NOP //  //24
    JR $0   //28

.data
