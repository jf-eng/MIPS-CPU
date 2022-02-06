// LWL
.config
	ARCH v
	ASSERT 32'hef000010
  
.text
    ADDIU $3 $0 #0x1234
    SH $3 #0($gp)
    ADDIU $3 $0 #0x5678
    SH $3 #2($gp)
    ADDIU $3 $0 #0x89ab
    SH $3 #4($gp)
    ADDIU $3 $0 #0xcdef
    SH $3 #6($gp)
    ADDIU $2 $0 #0x10         //0
    ADDIU $1 $0 #0x1111       //4
    LWL $1 #3($gp)               //8
    LWL $2 #7($gp)           //12
    JR $0                    //16
                              //20
.data
  #0x12345678                 // 24
  #0x89abcdef                 // 28

  







