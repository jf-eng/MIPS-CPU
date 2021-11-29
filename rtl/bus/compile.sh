#!/bin/bash

iverilog -Wall -g 2012 -o mips_cpu_bus_tb -s mips_cpu_bus_tb $(find . -name "*.v")

./mips_cpu_bus_tb

rm mips_cpu_bus_tb