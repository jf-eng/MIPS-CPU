#!/bin/bash

iverilog -Wall -g 2012 -o pc_tb -s pc_tb *.v

./pc_tb

rm pc_tb