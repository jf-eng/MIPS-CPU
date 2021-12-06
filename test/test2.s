// BEQ branch false

.config
    ARCH v
    ASSERT 32'h40C

.text
    LW $1 one
    LW $3 two
    BEQ $1 $3 here
    ADDIU $2 $1 #4 // $2 = #0x404
    ADDIU $2 $2 #4 // $2 = #0x408
    ADDIU $2 $2 #4 // $2 = #0x40C
here:
    JR $0
    NOP

.data
    one #0x400
    two #0x401

	