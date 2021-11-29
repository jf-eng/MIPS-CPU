#!/bin/bash

iverilog -Wall -g 2012 -o datapath -s datapath *.v ./*/*.v

./datapath
rm datapath