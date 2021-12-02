#!/bin/bash

iverilog -Wall -g 2012 -o mips_cpu_bus -s mips_cpu_bus $(find . -name "*.v")

rm mips_cpu_bus
