#!/usr/bin/env bash

# Figure out where everything is
SCRIPT=$(realpath $0)
SCRIPT_PATH=$(dirname $SCRIPT)
PANDOC_TEMPLATES=$(dirname $SCRIPT_PATH)
SHUNN_SHORT_STORY_DIR="$PANDOC_TEMPLATES/shunn/short"

# Create a temporary data directory
export PANDOC_DATA_DIR=$(mktemp -d)
# Copy the template.docx file to the temporary directory
cp $SHUNN_SHORT_STORY_DIR/template.docx $PANDOC_DATA_DIR/template.docx

# Run pandoc
pandoc $1 \
  --from markdown \
  --to docx \
  --lua-filter $SHUNN_SHORT_STORY_DIR/shunnshort.lua \
  --data-dir $PANDOC_DATA_DIR \
  --output $2

# Clean up the temporary directory
rm -rf $PANDOC_DATA_DIR
