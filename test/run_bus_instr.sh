#!/bin/bash

RTLPATH="$1"
INSTR="$2"

shopt -s nullglob

ALL_TB=("nowait" "wait_random" "wait_flipped" "wait_flipped_reversed")

if [[ $# -le 1 ]]; then
	echo "Please provide a path & instruction to test."
	exit 2
fi

ASM_FILES=$(ls ./bus/$INSTR/*.s)

for file in $ASM_FILES; do
	# Strip name
	STRIPPED=$(basename $file .s)

	# Assemble
	./assemble $file &>/dev/null

	if [[ $? -ne 0 ]]; then
		echo "$ERROR assembling ${file}$" >&2
		echo "$STRIPPED $INSTR Fail"
		continue
	fi
	
	for i in 0 1 2 3 ; do

		# Compile entire CPU w/ testbench & instruction to test
		iverilog -Wall -g 2012 -s $STRIPPED -o ./bus/$INSTR/$STRIPPED ./bus/mips_cpu_bus_tb.v \
				./bus/$INSTR/$STRIPPED.v $RTLPATH/mips_cpu_*.v $RTLPATH/mips_cpu/*.v \
				-P $STRIPPED.WAIT_TYPE=$i >&2
		if [[ $? -ne 0 ]]; then
			echo "$ERROR compiling ${file} with ${ALL_TB[i]}" >&2
			echo "$STRIPPED $INSTR Fail"
			continue 2
		fi

		# Run (Cannot run from here, must run in the folder itself for some reason)
		cd bus/$INSTR

		./$STRIPPED &>/dev/null

		# Check Fail
		if [[ $? -ne 0 ]]; then
			echo "$STRIPPED $INSTR Fail"
			rm $STRIPPED $STRIPPED.ram $STRIPPED.v mips_cpu_bus_tb.vcd &>/dev/null
			cd ../..
			continue 2
		fi

		cd ../..
	done

	rm ./bus/$INSTR/$STRIPPED.ram ./bus/$INSTR/$STRIPPED.v ./bus/$INSTR/$STRIPPED ./bus/$INSTR/mips_cpu_bus_tb.vcd &>/dev/null
	# If all pass, echo Pass
	echo "$STRIPPED $INSTR Pass"
done

