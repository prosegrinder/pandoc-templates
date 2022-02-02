param(
    [Alias('h')]
    [switch]$help,
    [Alias('o')]
    [string]$output,
    [Alias('x')]
    [switch]$overwrite
    # [Alias('m')]
    # [switch]$modern
)

if ($help) {
@"
md2long.ps1 -output DOCX [-overwrite] [-modern] FILES

  -o DOCX               -output DOCX
    Write the output to DOCX. Passed straight to pandoc as-is.
  -x                    -overwrite
    If output FILE exists, overwrite without prompting.
  -m                    -modern
    Use Shunn modern manuscript format (otherwise use Shunn classic)
  FILES
    One (1) or more Markdown file(s) to be converted to DOCX.
    Passed straight to pandoc as-is.
"@
Exit 0
}
if (-not $output) { 
  Write-Host "No -output argument defined."
  Exit 1
}
if ((Test-Path -Path $output) -and (-not($overwrite))) {
  Write-Host "$output exists."
  $overx = Read-Host -Prompt "Do you want to overwrite? (y/n)"
  if (-not($overx -match 'y')) {
      Write-Host 'Cancelling.'
      Exit 0
  } else {
      Write-Host 'Overwriting.'
  }
}
# if ($modern){
#   $TEMPLATE='template-modern.docx'
# } else {

# }
$TEMPLATE='template.docx'
$SHUNN_LONG_STORY_DIR=Join-Path $PSScriptRoot "..\shunn\long" | Resolve-Path

# https://stackoverflow.com/questions/34559553/create-a-temporary-directory-in-powershell
function New-TemporaryDirectory {
  $parent = [System.IO.Path]::GetTempPath()
  [string] $name = [System.Guid]::NewGuid()
  New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

# Create a temporary data directory
Write-Host 'Creating temporary directory.'
$env:PANDOC_DATA_DIR=New-TemporaryDirectory
Write-Host "Directory created: $env:PANDOC_DATA_DIR"

# Prep the template and reference directories
Copy-Item -Path $SHUNN_LONG_STORY_DIR\$TEMPLATE -Destination $env:PANDOC_DATA_DIR\template.zip
Expand-Archive -Path $env:PANDOC_DATA_DIR\template.zip -DestinationPath $env:PANDOC_DATA_DIR\template\
Expand-Archive -Path $env:PANDOC_DATA_DIR\template.zip -DestinationPath $env:PANDOC_DATA_DIR\reference\

# Set Lua filter path
$FILTERS_PATH=Join-Path $PSScriptRoot '..' | Resolve-Path
$env:LUA_PATH="$FILTERS_PATH/?.lua;;"

Write-Output "Resolving input files..."
[array]$inputs = foreach ($path in $args) {
  (Resolve-Path -Path $path).Path
}

# Run pandoc
Write-Output "Running Pandoc."
pandoc --from markdown --to docx `
    --lua-filter $SHUNN_LONG_STORY_DIR/shunnlong.lua `
    --data-dir $env:PANDOC_DATA_DIR `
    --output $output `
    @inputs
Write-Output "Pandoc completed successfully."

# Clean up the temporary directory
Remove-Item -Recurse -Force $env:PANDOC_DATA_DIR