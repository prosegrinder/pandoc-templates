param(
    [Alias('h')]
    [switch]$help,
    [Alias('o')]
    [string]$output,
    [Alias('x')]
    [switch]$overwrite,
    [Alias('m')]
    [switch]$modern
)

# Perhaps: https://www.powershellgallery.com/packages/Pscx/3.3.2
if ($help) {
@"
md2short.ps1 -output DOCX [-overwrite] [-modern] FILES

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
if ($modern){
    $TEMPLATE='template-modern.docx'
} else {
    $TEMPLATE='template.docx'
}


# https://stackoverflow.com/questions/34559553/create-a-temporary-directory-in-powershell
function New-TemporaryDirectory {
    $parent = [System.IO.Path]::GetTempPath()
    [string] $name = [System.Guid]::NewGuid()
    New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

# https://stackoverflow.com/questions/27768303/how-to-unzip-a-file-in-powershell
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

# https://stackoverflow.com/questions/1153126/how-to-create-a-zip-archive-with-powershell#13302548
function ZipFiles( $zipfilename, $sourcedir )
{
   $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
   [System.IO.Compression.ZipFile]::CreateFromDirectory($sourcedir,
        $zipfilename, $compressionLevel, $false)
}

# Figure out where everything is
$ShunnShortStoryDir=Join-Path $PSScriptRoot "..\shunn\short" | Resolve-Path
Get-ChildItem $ShunnShortStoryDir

# Create a temporary data directory
Write-Host 'Creating temporary directory.'
$env:PANDOC_DATA_DIR=New-TemporaryDirectory
Write-Host "Directory created: $env:PANDOC_DATA_DIR"

# Prep the template and reference directories
Copy-Item -Path $ShunnShortStoryDir\$TEMPLATE -Destination $env:PANDOC_DATA_DIR\template.zip
Expand-Archive -Path $env:PANDOC_DATA_DIR\template.zip -DestinationPath $env:PANDOC_DATA_DIR\template\
Expand-Archive -Path $env:PANDOC_DATA_DIR\template.zip -DestinationPath $env:PANDOC_DATA_DIR\reference\

# Set Lua filter path
$FILTERS_PATH=Join-Path $PSScriptRoot '..' | Resolve-Path
$env:LUA_PATH="$FILTERS_PATH/?.lua;;"

# Run pandoc
Write-Output "Running Pandoc."
pandoc --from markdown --to docx `
    --lua-filter $ShunnShortStoryDir/shunnshort.lua `
    --data-dir $env:PANDOC_DATA_DIR `
    --output $output `
    @args
Write-Output "Pandoc completed successfully."

# Clean up the temporary directory
Remove-Item -Recurse -Force $env:PANDOC_DATA_DIR
