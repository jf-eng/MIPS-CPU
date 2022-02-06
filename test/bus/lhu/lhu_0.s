.config
	ARCH v
	ASSERT 32'h00001356

.text 
  	LUI $1 #0x1357
	ADDIU $1 $1 #0x9bdf // 13570000 + FFFF9bdf = 1 1356 9BDF
	SW $1 #0($gp)
	LHU $2 #0($gp)
	JR $0

.data
  

  
  