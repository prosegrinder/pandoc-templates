#!/usr/bin/env bash

# Convert a Markdown file to .docx
# Rule 1: Use Pandoc only where necessary

# Figure out where everything is
SCRIPT="$(realpath "$0")"
SCRIPT_PATH="$(dirname "$SCRIPT")"
PANDOC_TEMPLATES="$(dirname "$SCRIPT_PATH")"
SHUNN_SHORT_STORY_DIR="$PANDOC_TEMPLATES/shunn/short"

# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash/
POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -i|--input)
    INFILE="$2"
    shift # past argument
    shift # past value
    ;;
    -o|--output)
    OUTFILE="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# Does the input file exist?
if [ ! -f "${INFILE}" ]; then
  echo "'${INFILE}' not found."
  exit 1
else
  INFILE=$(realpath ${INFILE})
fi

# Create a temporary data directory
echo "Creating temporary directory."
export PANDOC_DATA_DIR
PANDOC_DATA_DIR="$(mktemp -d)"
echo "Directory created: $PANDOC_DATA_DIR"

# Prep the template and reference directories
echo "Extracting $SHUNN_SHORT_STORY_DIR/template.docx to temporary directory."
unzip -ao "$SHUNN_SHORT_STORY_DIR/template.docx" -d "$PANDOC_DATA_DIR/template" > /dev/null
unzip -ao "$SHUNN_SHORT_STORY_DIR/template.docx" -d "$PANDOC_DATA_DIR/reference" > /dev/null
echo "Files extracted."

# Run pandoc
echo "Running Pandoc."
pandoc \
  --from=markdown \
  --to=docx \
  --lua-filter="$SHUNN_SHORT_STORY_DIR/shunnshort.lua" \
  --data-dir="$PANDOC_DATA_DIR" \
  --output="$OUTFILE" \
  "$INFILE"
echo "Pandoc completed successfully."

# Clean up the temporary directory
echo "Removing $PANDOC_DATA_DIR"
rm -rf "$PANDOC_DATA_DIR"
echo "Done."
