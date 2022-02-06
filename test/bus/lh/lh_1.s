.config
	ARCH v
	ASSERT 32'h00007bdf

.text 
  	LUI $1 #0x1357
	ADDIU $1 $1 #0x7bdf
	SW $1 #0($gp)
	LH $2 #2($gp)
	JR $0

.data
  
  