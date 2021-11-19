#!/bin/bash

iverilog -Wall -g 2012 -s external_ram_tb -o external_ram_tb *.v
./external_ram_tb