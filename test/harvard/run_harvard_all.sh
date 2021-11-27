#!/bin/bash

for d in */ ; do
	./run_harvard_instr.sh ${d::-1}
done

