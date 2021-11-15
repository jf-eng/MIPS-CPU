#!/bin/bash

TB="*_tb.v"
T=$(basename $TB .v)

iverilog -Wall -g 2012 -s $T -o $T *.v

if [[ $? -ne 0 ]]; then 
	echo "[SCRIPT] Compilation failed."
	exit 1
fi

./$T

if [[ $? -ne 0 ]]; then 
	echo "[SCRIPT] Tests failed."
	exit 1
fi

echo "[SCRIPT] Succeeded Tests"