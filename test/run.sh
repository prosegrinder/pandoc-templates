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

printf $fS '2. [Short] Other input format' $line
$BIN/md2short.sh --overwrite --from json $THIS_DIR/short/guidelines.json --output $RESULTS/short-json.docx

printf $fS '3. [Short] Modern style' $line
$BIN/md2short.sh -x --modern $THIS_DIR/short/line-break.md -o $RESULTS/short-modern.docx

printf $fS '4. [Long] Wildcard inputs' $line
$BIN/md2long.sh -x $THIS_DIR/long/*.md $THIS_DIR/short/*.md -o $RESULTS/long.docx

printf $fS '5. [Long] Other input format' $line
$BIN/md2long.sh -x --from json $THIS_DIR/long/*.json $THIS_DIR/short/*.json -o $RESULTS/long-json.docx

printf $fS '6. [Long] Modern style' $line
$BIN/md2long.sh -x --modern $THIS_DIR/long/0-prologue.md $THIS_DIR/long/1-the-beginning.md -o $RESULTS/long-modern.docx
