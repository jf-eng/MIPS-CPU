#!/bin/bash

INSTR="$1"

ASM_FILES=$(ls ./$INSTR/*.s)

for file in $ASM_FILES; do

	# Assemble
	./assemble $file &>/dev/null

	# Strip name

	STRIPPED=$(basename $file .s)

	# Compile entire CPU w/ testbench & instruction to test
	iverilog -Wall -g 2012 -s $STRIPPED -o ./$INSTR/$STRIPPED mips_cpu_harvard_tb.v ./$INSTR/$STRIPPED.v $(find ./../../rtl/harvard -name "*.v") &>/dev/null

	# Run (Cannot run from here, must run in the folder itself for some reason)
	cd $INSTR

	./$STRIPPED &>/dev/null

	# Check Pass/Fail
	if [[ $? -ne 0 ]]; then
		echo $STRIPPED $INSTR Fail
	else
		echo $STRIPPED $INSTR Pass
	fi

	# remove the files
	rm -rf $STRIPPED $STRIPPED.ram $STRIPPED.rom

	cd ..

done
