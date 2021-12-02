#!/bin/bash

iverilog -Wall -g 2012 -s mips_cpu_bus_tb -o mips_cpu_bus_tb mips_cpu_bus_tb.v fake_cpu.v

./mips_cpu_bus_tb

rm mips_cpu_bus_tb

