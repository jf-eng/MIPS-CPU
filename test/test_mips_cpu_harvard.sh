#!/bin/bash

RTLPATH="$1"
INSTR="$2"

# all tests
if [[ $# -eq 1 ]]; then
	./harvard/run_harvard_all.sh $RTLPATH
# specific test
else
	./harvard/run_harvard_instr.sh $RTLPATH $INSTR
fi
