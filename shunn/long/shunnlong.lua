-- https://github.com/jgm/pandoc/issues/2573#issuecomment-363839077
require "filters.wordcount"
require "filters.meta"
require "filters.docx.horizontalrule"
require "filters.docx.processheader"
require "filters.nonbreakemdash"

vars = {}

function Pandoc(doc, meta)
  local ossep = package.config:sub(1,1)
  local pandoc_data_dir = os.getenv('PANDOC_DATA_DIR')

  pandoc.walk_block(pandoc.Div(doc.blocks), wordcount)

  vars["#word_count#"] = format_word_count(round(word_count, -2))

  -- Process header XML files
  processHeaderFile(vars, pandoc_data_dir, 'header1')
  processHeaderFile(vars, pandoc_data_dir, 'header2')
  processHeaderFile(vars, pandoc_data_dir, 'footer1')

  -- Generate reference.docx file
  -- What OS am I on?
  -- https://stackoverflow.com/questions/295052/how-can-i-determine-the-os-of-the-system-from-within-a-lua-script
  if ossep == '/' then
    -- *nix (MacOS, Linux) should have zip available
    print("Zipping reference.docx using UNIX zip.")
    os.execute ("cd "
      .. pandoc_data_dir
      .. "/reference && zip -r ../reference.docx * > /dev/null")
  elseif ossep == '\\' then
    -- Windows should have powershell
    print("Zipping reference.zip using PowerShell.")
    os.execute("powershell Compress-Archive -Path "
      .. pandoc_data_dir
      .. "\\reference\\* "
      .. pandoc_data_dir
      .. "\\reference.zip")
    print("Renaming reference.zip to reference.docx.")
    os.execute("powershell Rename-Item -Path "
      .. pandoc_data_dir
      .. "\\reference.zip -NewName "
      .. pandoc_data_dir
      .. "\\reference.docx")
  else
    print("Unknown shell: " .. ossep)
    os.exit(1)
  end
end

