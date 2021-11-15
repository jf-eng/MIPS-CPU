#!/bin/bash

TB="regfile_tb"

iverilog -Wall -g 2012 -s $TB -o $TB *.v

if [[ $? -ne 0 ]]; then 
	echo "[SCRIPT] Compilation failed."
	exit 1
fi

./$TB

if [[ $? -ne 0 ]]; then 
	echo "[SCRIPT] Tests failed."
	exit 1
fi

echo "[SCRIPT] Succeeded Tests"