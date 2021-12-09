.config
	ARCH v
	ASSERT 0

.text

// STACK:
// 16: argument n (a0)
// 12: return address
// 08: saved register s7 (for $sp)
// 04: saved register s0 (for storing fib answer)
// 00: sp points here


	main:
		ADDIU $a0 $zero #4
		JAL fib
		NOP
		JR $zero
		NOP

	fib:
		ADDIU $sp $sp #-16
		SW $ra #12($sp)
		SW $s7 #8($sp)
		SW $s0 #4($sp)
		ADDU $s7 $sp $zero		// move sp into s7 -> s7 acts as fp
		SW $a0 #16($sp)			// move argument onto stack
		LW $v0 #16($sp)			// load argument into $v0
		SLTI $v0 $v0 2
        BEQ $v0 $zero notbase 	// branch if basecase not true
		NOP
		ADDIU $v0 $zero #1
		J exit 		        	// branch to exit calls
		NOP

	notbase:
		ADDIU $v0 $v0 #-1
		ADDU $a0 $v0 $zero		// move into argument
		JAL fib					// call fib(n-1)
		NOP
		ADDU $s0 $v0 $zero		// move answer into saved reg s0 

		LW $v0 #16($s7)
		ADDIU $v0 $v0 #-2
		ADDU $a0 $v0 $zero		// move into argument
		JAL fib					// call fib(n-2)
		NOP
		ADDU $v0 $s0 $v0		// add answers
		
	exit:
		ADDU $sp $s7 $zero		// restore sp <- s7 (frame pointer)
		LW $ra, #12($sp)
		LW $s7, #8($sp)
		LW $s0, #4($sp)
		ADDIU $sp $sp #16		// restore sp to before func call
		JR $ra					// exit
		NOP

.data

