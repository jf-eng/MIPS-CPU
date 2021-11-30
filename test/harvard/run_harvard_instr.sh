#!/bin/bash

INSTR="$1"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
ASM_FILES=$(ls ./$INSTR/*.s)


# # Options not bothered to implement
# while getopts "vkf:" options; do

# 	case "${options}" in
# 		v)
# 			VERBOSE=1
# 			echo "SET verbose"
# 			;;
# 		k)
# 			KEEP_FILES=1
# 			echo "SET keep"
# 			;;
# 		f)
# 			FILENAME=""
# 			echo "SET file TO ${OPTARG}"
# 	esac

# done

# if [[ -z FILENAME ]]; then
# 	echo "Please provide file name -f <name>"
# 	exit 2
# fi


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
	iverilog -Wall -g 2012 -s $STRIPPED -o ./$INSTR/$STRIPPED mips_cpu_harvard_tb.v ./$INSTR/$STRIPPED.v $(find ./../../rtl/harvard -name "*.v") &> comp_err.log

	if [[ $? -ne 0 ]]; then
		echo -e "${RED}ERROR compiling ${file}${NC}"
		cat comp_err.log
		rm comp_err.log
		exit 2
	fi
	rm comp_err.log

	# Run (Cannot run from here, must run in the folder itself for some reason)
	cd $INSTR

	./$STRIPPED &> /dev/null

	# Check Pass/Fail
	if [[ $? -ne 0 ]]; then
		echo -e "${RED}$STRIPPED $INSTR Fail${NC}"
	else
		echo -e "${GREEN}$STRIPPED $INSTR Pass${NC}"
	fi

	# remove the files
	rm -rf $STRIPPED $STRIPPED.ram $STRIPPED.rom $STRIPPED.v mips_cpu_harvard_tb.vcd

	cd ..

done
