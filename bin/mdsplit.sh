#!/bin/bash
# Convenience script to split a single Markdown file into chapters.

# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash/
POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -f|--file)
    INFILE="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--directory)
    OUTDIR="$2"
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

if [ ! -f "$INFILE" ]; then
  echo "'$INFILE' not found."
  exit 1
fi

# https://stackoverflow.com/questions/33889814/how-do-i-split-a-markdown-file-into-separate-files-at-the-heading
TMPDIR=$(mktemp -d)
FNAME="${INFILE##*/}"
TMPEPUB="${TMPDIR}/${FNAME%.*}.epub"

# Convert to epub first.
echo "Creating intermediate file: '$TMPEPUB'"
pandoc -f markdown -t epub --wrap=none -o "$TMPEPUB" "$INFILE"
echo "Extracting contents of '$TMPEPUB'"
unzip -q "$TMPEPUB" -d "$TMPDIR"

# TODO: Prompt for confirmation if ${OUTDIR} exists.
mkdir -p "${OUTDIR}"

# Convert individual chapters to gfm
for chapter in "$TMPDIR"/EPUB/text/*.xhtml;
do
  FILE="${chapter##*/}"
  OUTFILE="${FILE%.*}.md"
  echo "Converting ${chapter} to ${OUTDIR}/${OUTFILE}."
  # https://stackoverflow.com/questions/35807092/why-pandoc-keeps-span-and-div-tags-when-converting-html-to-markdown#35812743
  pandoc --from=html-native_divs-native_spans --to=gfm --columns=80 --output="${OUTDIR}/${OUTFILE}" "${chapter}"
  # mv ${chapter/xhtml/md} ${PROJDIR}/manuscript
done

echo "Cleaning up ${TMPDIR}"
rm -rf "${TMPDIR}"
