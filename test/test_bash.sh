#!/bin/bash
# Test

# Single file
#../bin/md2short.sh -x -o '../short-out.docx' './short/guidelines.md'

# ===== Powershell
pwsh ../bin/md2short.ps1 -x -m -o '../short-out-ps.docx' './short/guidelines.md'

# Various line break conventions
pwsh ../bin/md2short.ps1 -overwrite -modern -output $HOME/Documents/short-line-break.docx './test/short/line-break.md'

# Multiple wildcard inputs
pwsh ../bin/md2long.ps1 -x -o 'long-wild.docx' 'test/long/*.md' 'test/short/*.md'

