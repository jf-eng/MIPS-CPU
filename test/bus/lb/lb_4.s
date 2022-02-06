// LB
.config
	ARCH v
	ASSERT 32'hFFFFFFFF
  
.text
    ADDIU $3 $0 #0x0010
    ADDIU $4 $0 #0Xbfc0
    SH $4 #0($gp)
    SH $3 #2($gp) 
    ADDIU $2 $0 #15  
    ADDIU $1 $0 #14  
    SW $2 #0($gp)      
    SW $1 #4($gp)      
    LB $1 #3($gp)      
    LB $2 #7($gp)      
    SUBU $2 $2 $1    
    JR $0            

.data





