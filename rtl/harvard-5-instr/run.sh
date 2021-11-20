#!/bin/bash

iverilog -Wall -g 2012 -s mips_cpu_harvard_tb -o mips_cpu_harvard_tb *.v

./mips_cpu_harvard_tb
