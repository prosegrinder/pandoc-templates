$BIN=(Resolve-Path '../bin/')

$fH="`n`t{0}`n"
$fS="`n`t{0}`n`t{1}`n"
$line='----------------------------------------'

New-Item -Path ./results -ItemType directory -ErrorAction SilentlyContinue

Write-Output ($fH -f '=============== Powershell Tests ===============')

Write-Output ($fS -f '1. [Short] Single input', $line)
.("$BIN\md2short.ps1") -overwrite ./short/guidelines.md -output ./results/short-ps.docx

Write-Output ($fS -f '2. [Short] Modern style', $line)
.("$BIN\md2short.ps1") -x -modern ./short/line-break.md -o ./results/short-modern-ps.docx

Write-Output ($fS -f '3. [Long] Wildcard inputs', $line)
.("$BIN\md2long.ps1") -x ./long/*.md ./short/*.md -o ./results/long-ps.docx

Write-Output ($fS -f '4. [Long] Modern style', $line)
.("$BIN\md2long.ps1") -x -modern ./long/0-prologue.md ./long/1-the-beginning.md -o ./results/long-modern-ps.docx