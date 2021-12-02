#!/bin/bash

iverilog -Wall -g 2012 -o ir_tb -s ir_tb *.v

./ir_tb
rm ir_tb