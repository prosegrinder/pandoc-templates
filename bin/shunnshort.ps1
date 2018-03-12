param([string]$infile, [string]$outfile)

# Perhaps: https://www.powershellgallery.com/packages/Pscx/3.3.2

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
$ShunnShortStoryDir=Join-Path $PSScriptRoot "..\shunn\short"
Get-ChildItem $ShunnShortStoryDir

# Create a temporary data directory
$env:PANDOC_DATA_DIR=New-TemporaryDirectory

# Prep the template and reference directories
Copy-Item -Path $ShunnShortStoryDir\template.docx -Destination $env:PANDOC_DATA_DIR\template.zip
Expand-Archive -Path $env:PANDOC_DATA_DIR\template.zip -DestinationPath $env:PANDOC_DATA_DIR\template\
Expand-Archive -Path $env:PANDOC_DATA_DIR\template.zip -DestinationPath $env:PANDOC_DATA_DIR\reference\

# Run pandoc
Write-Output "Running Pandoc."
pandoc $infile --from markdown --to docx --lua-filter $ShunnShortStoryDir/shunnshort.lua --data-dir $env:PANDOC_DATA_DIR --output $outfile
Write-Output "Pandoc completed successfully."

# Clean up the temporary directory
Remove-Item $env:PANDOC_DATA_DIR
