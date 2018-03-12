#!/usr/bin/env bash

# Rule 1: Do only what's necessary in Pandoc

# Figure out where everything is
SCRIPT=$(realpath $0)
SCRIPT_PATH=$(dirname $SCRIPT)
PANDOC_TEMPLATES=$(dirname $SCRIPT_PATH)
SHUNN_SHORT_STORY_DIR="$PANDOC_TEMPLATES/shunn/short"

# Create a temporary data directory
echo "Creating temporary directory."
export PANDOC_DATA_DIR=$(mktemp -d)
echo "Directory created: $PANDOC_DATA_DIR"

# Prep the template and reference directories
echo "Extracting $SHUNN_SHORT_STORY_DIR/template.docx to temporary directory."
unzip -ao $SHUNN_SHORT_STORY_DIR/template.docx -d $PANDOC_DATA_DIR/template
unzip -ao $SHUNN_SHORT_STORY_DIR/template.docx -d $PANDOC_DATA_DIR/reference
echo "Files extracted."

# Run pandoc
echo "Running Pandoc."
pandoc $1 \
  --from markdown \
  --to docx \
  --lua-filter $SHUNN_SHORT_STORY_DIR/shunnshort.lua \
  --data-dir $PANDOC_DATA_DIR \
  --output $2
echo "Pandoc completed successfully."

# Clean up the temporary directory
echo "Removing $PANDOC_DATA_DIR"
rm -rf $PANDOC_DATA_DIR
echo "Done."
