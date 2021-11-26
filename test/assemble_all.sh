#!/bin/bash

for file in $(find . -name "*.s"); do
	./assemble $file
done
