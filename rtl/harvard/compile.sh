#!/bin/bash

iverilog -Wall -g 2012 -o mips_cpu_harvard -s mips_cpu_harvard $(find . -name "*.v")

rm mips_cpu_harvard
