#!/bin/bash

iverilog -Wall -g 2012 -o mips_cpu_harvard -s mips_cpu_harvard *.v ./*/*.v ./*/*/*.v

./mips_cpu_harvard

rm mips_cpu_harvard