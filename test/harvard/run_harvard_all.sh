#!/bin/bash

# echo "Found $(find */ -maxdepth 0 -type d | wc -l) instructions."
# echo "Found $(find */*.s | wc -l) tests."

for d in */ ; do
	./run_harvard_instr.sh ${d::-1}
done

