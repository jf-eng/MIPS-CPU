.config
	ARCH v
	ASSERT 32'hf

.text
		J loop
  loop2:
    ADDIU $2 $0 #8
    JR $31
    ADDIU $2 $2 #1
    JR $0
    NOP
  loop:
    ADDIU $2 $0 #6
    JAL loop2
    ADDIU $2 $2 #1
    ADDIU $2 $0 #15
		JR $0

.data
