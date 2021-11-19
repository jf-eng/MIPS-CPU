#!/bin/bash

iverilog -Wall -g 2012 -s mips_cpu_harvard -o mips_cpu_harvard *.v

./mips_cpu_harvard
