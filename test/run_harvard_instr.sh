#!/bin/bash

RTLPATH="$1"
INSTR="$2"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ $# -le 1 ]]; then
	echo "Please provide a path & instruction to test."
	exit 2
fi

ASM_FILES=$(ls ./harvard/$INSTR/*.s)


for file in $ASM_FILES; do

	# Assemble
	./assemble $file &> assem_err.log

	if [[ $? -ne 0 ]]; then
		echo -e "${RED}ERROR assembling ${file}${NC}"
		cat assem_err.log
		rm assem_err.log
		exit 2
	fi
	rm assem_err.log

	# Strip name
	STRIPPED=$(basename $file .s)

	# Compile entire CPU w/ testbench & instruction to test
	iverilog -Wall -g 2012 -s $STRIPPED -o ./harvard/$INSTR/$STRIPPED ./harvard/mips_cpu_harvard_tb.v ./harvard/$INSTR/$STRIPPED.v $(find $RTLPATH -name "*.v") &> comp_err.log

	if [[ $? -ne 0 ]]; then
		echo -e "${RED}ERROR compiling ${file}${NC}"
		cat comp_err.log
		rm comp_err.log
		exit 2
	fi
	rm comp_err.log

	# Run (Cannot run from here, must run in the folder itself for some reason)
	cd harvard/$INSTR

	./$STRIPPED &> /dev/null

	# Check Pass/Fail
	if [[ $? -ne 0 ]]; then
		echo -e "${RED}$STRIPPED $INSTR Fail${NC}"
	else
		echo -e "${GREEN}$STRIPPED $INSTR Pass${NC}"
	fi

	# remove the files
	rm -rf $STRIPPED $STRIPPED.ram $STRIPPED.rom $STRIPPED.v mips_cpu_harvard_tb.vcd

	cd ../..

done
