#!/bin/bash

iverilog -Wall -g 2012 -s bus_memory_tb -o bus_memory_tb *.v
./bus_memory_tb