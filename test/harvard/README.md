# File Descriptions

## `./assemble`

This is the assembler program which automaticall generates `.ram` `.rom` and `.v` files for automated testing.

## `./run_harvard_all.sh`

This script automatically runs all of the tests available.

## `./run_harvard_instr.sh <instr>`

This script runs assembles, compiles, and tests a specific instruction based on the `<instr>` provided. It then spits out "Pass" or "Fail".

## `mips_cpu_harvard_tb.v`

This is the single testbench which acts as an interface between the cpu which we are testing and the specific tests we are conducting, it takes in parameters used to load `.ram` and `.rom` files into the CPU and also provides `active` and `register_v0` outputs for automated testing at the top level.