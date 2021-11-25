import sys
import os

def int_to_bin(integer, length):
	def invert_bit(bit):
		if bit == '0':
			return '1'
		elif bit == '1':
			return '0'
	
	def bin_str_add1(bin_arr):
		for i in range(0, len(bin_arr)):
			if bin_arr[len(bin_arr) - i - 1] == '0':
				bin_arr[len(bin_arr) - i - 1] = '1'
				return "".join(bin_arr)
		return '0'*len(bin_arr)

	if integer >= 0:
		return bin(integer)[2:].zfill(length)
	else:
		pos = bin(-integer)[2:].zfill(length)
		neg = [invert_bit(c) for c in pos]
		return bin_str_add1(neg)

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

# Branch calculator
def branch_label(label, line_ind, jump_labels):
	return int_to_bin(jump_labels[label] - line_ind, 16)

# Page Jump calculator 0xFC00000 >> 2 = 0x3F00000
def jump_label(label, line_ind, jump_labels):
	return int_to_bin(jump_labels[label] + 0x3F00000, 26)


# Assembles 1 line
def parse_line(line, line_ind, jump_labels):
	tokens = [w.strip(',') for w in line.split()]
	print("Assembling " + line + "...")
	opcode = OPCODE[tokens[0].upper()];


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

		if(tokens[2][0] == "#"):
			offset = process_num(tokens[2], 16)
		else:
			offset = branch_label(tokens[2], line_ind, jump_labels)
		return op(opcode) + rs + rt + offset;

	# ALL J-type instructions
	elif opcode == 2 or opcode == 3: # J & JAL
		
		if tokens[1][0] == "#":
			immediate = process_num(tokens[1], 26)
		else:
			print(tokens[1])
			immediate = jump_label(tokens[1], line_ind, jump_labels)
			print(immediate)
		
		return op(opcode) + immediate

	# ALL I-type instructions
	else:
		if opcode == OPCODE["BEQ"] or opcode == OPCODE["BNE"]:
			rs = reg(tokens[1])
			rt = reg(tokens[2])
			if(tokens[3][0] == "#"):
				offset = process_num(tokens[3], 16)
			else:
				offset = branch_label(tokens[3], line_ind, jump_labels)
			return op(opcode) + rs + rt + offset
		elif opcode == OPCODE["BLEZ"] or opcode == OPCODE["BGTZ"]:
			rs = reg(tokens[1])
			rt = "00000"
			if(tokens[2][0] == "#"):
				offset = process_num(tokens[2], 16)
			else:
				offset = branch_label(tokens[2], line_ind, jump_labels)
			return op(opcode) + rs + rt + offset
		elif opcode == OPCODE["ADDIU"] or opcode == OPCODE["SLTI"] or \
				opcode == OPCODE["SLTIU"] or opcode == OPCODE["ANDI"] or \
				opcode == OPCODE["ORI"] or opcode == OPCODE["XORI"]:
			rt = reg(tokens[1])
			rs = reg(tokens[2])
			immediate = process_num(tokens[3], 16)
			return op(opcode) + rs + rt + immediate
		elif opcode == OPCODE["LUI"]:
			rt = reg(tokens[1])
			immediate = process_num(tokens[2], 16)
			return op(opcode) + '0'*5 + rt + immediate

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
	lines = [l[:l.find("//")] for l in f.readlines()] # removes comments
	lines = [l.strip() for l in lines] # strips whitespace & gets lines
	lines = [v for v in lines if v != ""]
	# Do first pass on all lines
	# section .text .config
	
	# print(lines)

	dot_indexes = {}
	jump_labels = {}

	for n, l in enumerate(lines): 
		# extract indexes of .config, .text, .data
		if len(l) > 0 and l[0] == ".":
			dot_indexes[l] = n
		# extract indexes of label: 
		if len(l) > 0 and l[-1] == ":":
			lines.remove(l)
			jump_labels[l[:-1]] = n - dot_indexes[".text"] - 1
	

	config = lines[dot_indexes[".config"]+1:dot_indexes[".text"]]
	instr = lines[dot_indexes[".text"]+1:dot_indexes[".data"]]
	data = lines[dot_indexes[".data"]+1:]

	instr_word_count = len(instr)
	
	# Do second pass on instr
	binlines = [] 
	for line_num, i in enumerate(instr):
		binlines.append(parse_line(i, line_num, jump_labels) + " // " + i + "\n")
	
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