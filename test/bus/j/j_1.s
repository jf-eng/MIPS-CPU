.config
	ARCH v
	ASSERT 32'h9

.text
		J loop
  loop2:
    ADDIU $2 $0 #8
    JR $0
    ADDIU $2 $2 #1
  loop:
    ADDIU $2 $0 #6
    J loop2
    ADDIU $2 $2 #1
		JR $0

.data
