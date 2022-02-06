#!/bin/bash

chmod +x ./test/run_bus_all.sh ./test/run_bus_instr.sh

RTLPATH="$1"
INSTR="$2"

cd test/

if [[ "$RTLPATH" != /* ]]; then
	RTLPATH="../$RTLPATH"
fi

# all tests
if [[ $# -eq 1 ]]; then
	./run_bus_all.sh $RTLPATH
# specific test
else
	
	./run_bus_instr.sh $RTLPATH $INSTR
fi
