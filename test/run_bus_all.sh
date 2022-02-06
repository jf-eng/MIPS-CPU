#!/bin/bash

RTLPATH="$1"

for d in ./bus/*/ ; do
	INSTR=`basename $d /`
	./run_bus_instr.sh $RTLPATH $INSTR
done

