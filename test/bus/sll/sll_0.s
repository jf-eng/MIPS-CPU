    //tests 2 shifted by 2 in reg 2
    .config
            ARCH v
            ASSERT 32'b0100
    .text
            ADDIU $1 $0 #0b0001
            SLL $2 $1 2
            JR $0
    .data
