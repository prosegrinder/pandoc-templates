#!/usr/bin/env bash

SCRIPT=$(realpath $0)
SCRIPT_PATH=$(dirname $SCRIPT)
PANDOC_TEMPLATES=$(dirname $SCRIPT_PATH)
export PANDOC_DATA_DIR="$PANDOC_TEMPLATES/shunn/shortstory"
pandoc $1 --from markdown --to docx --lua-filter $PANDOC_DATA_DIR/shortstory.lua --data-dir $PANDOC_DATA_DIR --output $2
