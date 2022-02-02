#!/bin/bash
# Test

# Single file
#../bin/md2short.sh -x -o '../short-out.docx' './short/guidelines.md'

# Powershell
pwsh ../bin/md2short.ps1 -x -m -o '../short-out-ps.docx' './short/guidelines.md'