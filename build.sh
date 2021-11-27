#!/bin/bash

pyinstaller --onefile assemble.py

rm -rf assemble.spec build/ __pycache__
