//

.config
  ARCH v
  ASSERT 15

.text
    ADDIU $1 $0 #10
    ADDIU $3 $0 #10
    J jmp
    NOP

    jmp:
        BEQ $1 $3 jmp2
        NOP
        JR $0
        NOP
    
    jmp2:
        ADDIU $2 $0 #15
        JR $0

.data
