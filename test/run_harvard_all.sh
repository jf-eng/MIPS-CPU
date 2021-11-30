#!/bin/bash

# echo "Found $(find */ -maxdepth 0 -type d | wc -l) instructions."
# echo "Found $(find */*.s | wc -l) tests."

RTLPATH="$1"

for d in ./harvard/*/ ; do
	INSTR=`basename $d /`
	./run_harvard_instr.sh $RTLPATH $INSTR
done

