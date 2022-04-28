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
$BIN/md2short.sh --overwrite $THIS_DIR/short/guidelines.md --output $RESULTS/short.docx

printf $fS '1. [Short] Modern style' $line
$BIN/md2short.sh -x --modern $THIS_DIR/short/line-break.md -o $RESULTS/short-modern.docx

printf $fS '3. [Long] Wildcard input' $line
$BIN/md2long.sh -x -o $RESULTS/long.docx $THIS_DIR/long/*.md

printf $fH '=============== Powershell Tests ==============='

printf $fS '1. [Short] Single input' $line
pwsh $BIN/md2short.ps1 -overwrite $THIS_DIR/short/guidelines.md -output $RESULTS/short-ps.docx

printf $fS '2. [Short] Modern style' $line
pwsh $BIN/md2short.ps1 -x -modern $THIS_DIR/short/line-break.md -o $RESULTS/short-modern-ps.docx

printf $fS '3. [Long] Multiple wildcard inputs' $line
pwsh $BIN/md2long.ps1 -x "$THIS_DIR/long/*.md" "$THIS_DIR/short/*.md" -o $RESULTS/long-multi-ps.docx

printf $fS '4. [Long] Modern style' $line
pwsh $BIN/md2long.ps1 -overwrite -modern $THIS_DIR/long/0-prologue.md $THIS_DIR/long/1-the-beginning.md -output $RESULTS/long-modern-ps.docx