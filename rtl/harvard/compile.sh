#!/bin/bash

iverilog -Wall -g 2012 -o mips_cpu_harvard_tb -s mips_cpu_harvard_tb *.v ./*/*.v ./*/*/*.v

./mips_cpu_harvard_tb

rm mips_cpu_harvard_tb