# EE2-MIPS-CPU Assembler

Assembler wrote in Python by Derek Lai

This assembler implements a subset of the MIPS I instruction set for coursework purposes, to see full details see here https://github.com/m8pple/elec50010-2021-cpu-cw.

Executable is built from script using PyInstaller

Binaries/executable is in `/dist` folder.
Testcases used to verify the assembler are in `/test`

## Usage

Assembler can assemble multiple filepaths and produces a `<filename>.mem` binary file for each filepath in their respective folders.

`./assemble <file1> [<file2> <file3> ...]`

## Syntax & Programming

**REQUIRED:**
1. A program must have `.config`, `.text`, and `.data` section labels.
2. A program must declare which architecture it wants the assembler to build to under the config section.
- `ARCH h` to build to harvard architecture - generates .rom and .ram files
- `ARCH v` to build to von neumann architecture - generates .ram file

**Info:**

Config is used to mark the start of assembler configuration.

Text and data labels are used to mark the start of instructions and initial ram values.

**Example Program:**
```
.config
	ARCH h // meaning harvard, v for von neumann

.text
		ADDIU $2 $0 #0x10
		ADDIU $3 $0 #1
	loop:
		ADDU $0 $0 $0 // this line is where "loop" points to
		BGTZ $2 loop // can reference labels for branch & jump instructions
		SUBU $2 $2 $3
	end:
		JR $0

.data
		#1 // data can only be integers as of now
		#0x1234
		#0b10101
```

## Need to Implement
- Endian change option
- Error detection
