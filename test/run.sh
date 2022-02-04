#!/bin/bash

THIS_DIR=`dirname "$0"`
BIN=$(realpath $THIS_DIR/'../bin/')
RESULTS=$(realpath $THIS_DIR/'results')

mkdir -p $RESULTS

fH='\n\t%s\n\n'
fS='\t%s\n\t%s\n'
line='----------------------------------------'

printf $fH '================== Bash Tests =================='

printf $fS '1. [Short] Single input' $line
$BIN/md2short.sh -x -o $RESULTS/short.docx $THIS_DIR/short/guidelines.md

printf $fS '2. [Long] Wildcard' $line
$BIN/md2long.sh -x -o $RESULTS/long.docx $THIS_DIR/long/*.md
   
printf $fH '=============== Powershell Tests ==============='

printf $fS '1. [Short] Single input' $line
pwsh $BIN/md2short.ps1 -x -m -o $RESULTS/short-out-ps.docx $THIS_DIR/short/guidelines.md

printf $fS '2. [Short] Various line break conventions' $line
pwsh $BIN/md2short.ps1 -overwrite -modern -output $RESULTS/short-line-break-ps.docx $THIS_DIR/short/line-break.md

printf $fS '3. [Long] Multiple wildcard inputs' $line
# Wildcards must be quoted because Windows shell doesn't expand globs automatically
pwsh $BIN/md2long.ps1 -x -o $RESULTS/long-multi-ps.docx "$THIS_DIR/long/*.md" "$THIS_DIR/short/*.md"
