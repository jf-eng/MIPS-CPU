#!/bin/bash

iverilog -Wall -g 2012 -s ram -o ram *.v

./ram