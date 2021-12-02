#!/bin/bash

iverilog -Wall -g 2012 -o controlpath -s controlpath *.v ./*/*.v

./controlpath
rm controlpath