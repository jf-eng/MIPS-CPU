import sys
import os

def int_to_bin(integer, len):
	return bin(integer)[2:].zfill(len);

def process_num(imm, len):
	return int_to_bin(int(imm.strip('#'), 0), len)

def shiftamt(shamt):
	return int_to_bin(int(shamt.strip('#')), 5)

def op(opcode):
	return int_to_bin(opcode, 6)
	
def func(func_code):
	return int_to_bin(func_code, 6)

def reg(token):
	return int_to_bin(int(token.strip('$')), 5)

# Assembles 1 line
def parse_line(line):
	tokens = [w.strip(',') for w in line.split()]
	print("Assembling " + line + "...")
	opcode = OPCODE[tokens[0]];

	# ALL R-type instructions
	if opcode == 0: 
		func_code = FUNCCODE[tokens[0]]
		if func_code == FUNCCODE["JR"] or func_code == FUNCCODE["MTHI"] \
				or func_code == FUNCCODE["MTLO"]:
			# eg. JR $2 or MTHI $3
			rs = reg(tokens[1])
			return op(opcode) + rs + '0'*15 + func(func_code)
		elif func_code == FUNCCODE["DIV"] or func_code == FUNCCODE["DIVU"] \
				or func_code == FUNCCODE["MULT"] or func_code == FUNCCODE["MULTU"]:
			rs = reg(tokens[1])
			rt = reg(tokens[2])
			return op(opcode) + rs + rt + '0'*10 + func(func_code)
		elif func_code == FUNCCODE["SLL"] or func_code == FUNCCODE["SRL"] \
				or func_code == FUNCCODE["SRA"]:
			rd = reg(tokens[1])
			rt = reg(tokens[2])
			sa = shiftamt(tokens[3])
			return op(opcode) + '0'*5 + rt + rd + sa + func(func_code)
		elif func_code == FUNCCODE["JALR"]:
			if len(tokens) == 2: # rd implied to be 31
				rd = reg("$31")
				rs = reg(tokens[1])
			else:
				rd = reg(tokens[1])
				rs = reg(tokens[2])
			return op(opcode) + rs + '0'*5 + rd + '0'*5 + func(func_code)
		elif func_code == FUNCCODE["SLLV"] or func_code == FUNCCODE["SRAV"] \
				or func_code == FUNCCODE["SRLV"]:
			rd = reg(tokens[1])
			rt = reg(tokens[2])
			rs = reg(tokens[3])
			return op(opcode) + rs + rt + rd + '0'*5 + func(func_code)
		else:
			rd = reg(tokens[1])
			rs = reg(tokens[2])
			rt = reg(tokens[3])
			return op(opcode) + rs + rt + rd + '0'*5 + func(func_code)

	# Special Branches
	elif opcode == 1: # BGEZ & BGEZAL & BLTZ & BLTZAL
		if tokens[0] == "BGEZ":
			rt = "00001"
		elif tokens[0] == "BGEZAL":
			rt = "10001"
		elif tokens[0] == "BLTZ":
			rt = "00000"
		elif tokens[0] == "BLTZAL":
			rt = "10000"
		rs = reg(tokens[1])
		offset = process_num(tokens[2], 16)
		return op(opcode) + rs + rt + offset;

	# ALL J-type instructions
	elif opcode == 2 or opcode == 3: # J & JAL
		return op(opcode) + process_num(tokens[1], 26)

	# ALL I-type instructions
	else:
		if opcode == OPCODE["BEQ"] or opcode == OPCODE["BNE"]:
			rs = reg(tokens[1])
			rt = reg(tokens[2])
			offset = process_num(tokens[3], 16)
			return op(opcode) + rs + rt + offset
		elif opcode == OPCODE["BLEZ"] or opcode == OPCODE["BGTZ"]:
			rs = reg(tokens[1])
			rt = "00000"
			offset = process_num(tokens[2], 16)
			return op(opcode) + rs + rt + offset
		elif opcode == OPCODE["ADDIU"] or opcode == OPCODE["SLTI"] or \
				opcode == OPCODE["SLTIU"] or opcode == OPCODE["ANDI"] or \
				opcode == OPCODE["ORI"] or opcode == OPCODE["XORI"] or \
				opcode == OPCODE["LUI"]:
			rt = reg(tokens[1])
			rs = reg(tokens[2])
			immediate = process_num(tokens[3], 16)
			return op(opcode) + rs + rt + immediate

		# LOADSTORE INSTRUCTIONS eg. LW rt, offset(base) 
		else:
			rt = reg(tokens[1])
			l = tokens[2].find('(')
			r = tokens[2].find(')')
			base = reg(tokens[2][l+1:r])
			offset = process_num(tokens[2][:l], 16)
			return op(opcode) + base + rt + offset


# Assembles every line in file
def assemble(filepath):
	f = open(filepath, 'r')
	lines = [l.strip() for l in f.readlines()] # strips whitespace & gets lines
	binlines = [] 
	for line in lines:
		binlines.append(parse_line(line) + " // " + line + "\n")
	# print(binlines)
	outpath = os.path.splitext(filepath)[0] + ".mem"
	outF = open(outpath, 'w')
	outF.writelines(binlines)
	print("Output written to " + outpath)

	f.close()
	outF.close()


FUNCCODE = {
	"ADDU"  : 0b100001,
	"AND"   : 0b100100,
	"DIV"   : 0b011010,
	"DIVU"  : 0b011011,
	"JALR"  : 0b001001,
	"JR"    : 0b001000,
	"MTHI"  : 0b010001,
	"MTLO"  : 0b010011,
	"MULT"  : 0b011000,
	"MULTU" : 0b011001,
	"OR"    : 0b100101,
	"SLL"   : 0b000000,
	"SLLV"  : 0b000100,
	"SLT"   : 0b101010,
	"SLTU"  : 0b101011,
	"SRA"   : 0b000011,
	"SRAV"  : 0b000111,
	"SRL"   : 0b000010,
	"SRLV"  : 0b000110,
	"SUBU"  : 0b100011,
	"XOR"   : 0b100110,
}

OPCODE = {
	"ADDU"  : 0b000000,
	"AND"   : 0b000000,
	"DIV"   : 0b000000,
	"DIVU"  : 0b000000,
	"JALR"  : 0b000000,
	"JR"    : 0b000000,
	"MTHI"  : 0b000000,
	"MTLO"  : 0b000000,
	"MULT"  : 0b000000,
	"MULTU" : 0b000000,
	"OR"    : 0b000000,
	"SLL"   : 0b000000,
	"SLLV"  : 0b000000,
	"SLT"   : 0b000000,
	"SLTU"  : 0b000000,
	"SRA"   : 0b000000,
	"SRAV"  : 0b000000,
	"SRL"   : 0b000000,
	"SRLV"  : 0b000000,
	"SUBU"  : 0b000000,
	"XOR"   : 0b000000,
	"BGEZ"  : 0b000001,
	"BGEZAL": 0b000001,
	"BLTZ"  : 0b000001,
	"BLTZAL": 0b000001,
	"J"     : 0b000010,
	"JAL"   : 0b000011,
	"BEQ"   : 0b000100,
	"BNE"   : 0b000101,
	"BLEZ"  : 0b000110,
	"BGTZ"  : 0b000111,
	"ADDIU" : 0b001001,
	"SLTI"  : 0b001010,
	"SLTIU" : 0b001011,
	"ANDI"  : 0b001100,
	"ORI"   : 0b001101,
	"XORI"  : 0b001110,
	"LUI"   : 0b001111,
	"LB"    : 0b100000,
	"LH"    : 0b100001,
	"LWL"   : 0b100010,
	"LW"    : 0b100011,
	"LBU"   : 0b100100,
	"LHU"   : 0b100101,
	"LWR"   : 0b100110,
	"SB"    : 0b101000,
	"SH"    : 0b101001,
	"SW"    : 0b101011,
}


# Assemble every file
for filepath in sys.argv[1:]:
	assemble(filepath)