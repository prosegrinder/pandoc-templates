-- https://github.com/jgm/pandoc/issues/2573#issuecomment-363839077

local hashrule = [[<w:p>
<w:pPr>
  <w:pStyle w:val="BodyText"/>
  <w:ind w:firstLine="0"/>
  <w:jc w:val="center"/>
</w:pPr>
<w:r>
  <w:t>#</w:t>
</w:r>
</w:p>]]

local vars = {}
local word_count = 0
local pandoc_data_dir = os.getenv('PANDOC_DATA_DIR')
local ossep = package.config:sub(1,1)


function Meta(meta)
  for k, v in pairs(meta) do
    if v.t == "MetaInlines" then
      vars["#" .. k .. "#"] = pandoc.utils.stringify(v)
    end
  end
end

function HorizontalRule(el)
    return pandoc.RawBlock('openxml', hashrule)
end

function processHeaderFile(headerFilename)
  local tFilename = pandoc_data_dir .. ossep .. 'template' .. ossep .. 'word' .. ossep .. headerFilename .. '.xml'
  local templateFile = io.open(tFilename,'r')
  local content = templateFile:read("*a")
  templateFile:close()

  for k, v in pairs(vars) do
    if vars[k] == nil then
      content = string.gsub(content, k, '')
    else
      content = string.gsub(content, k, vars[k])
    end
  end

  local rFilename = pandoc_data_dir .. ossep .. 'reference' .. ossep .. 'word' .. ossep .. headerFilename .. '.xml'
  local referenceFile = io.open(rFilename,'w')
  referenceFile:write(content)
  referenceFile:close()
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

wordcount = {
  Str = function(el)
    -- we don't count a word if it's entirely punctuation:
    if el.text:match("%P") then
      word_count = word_count + 1
    end
  end,

  Code = function(el)
    _,n = el.text:gsub("%S+","")
    word_count = word_count + n
  end,

  CodeBlock = function(el)
    _,n = el.text:gsub("%S+","")
    word_count = word_count + n
  end
}

function comma_value(amount)
  local formatted = string.format("%i", amount)
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function Pandoc(doc, meta)
  pandoc.walk_block(pandoc.Div(doc.blocks), wordcount)

  vars["#word_count#"] = comma_value(round(word_count, -2))

  -- Process header XML files
  processHeaderFile('header1')
  processHeaderFile('header2')
  processHeaderFile('footer1')

  -- Generate reference.docx file
  -- What OS am I on?
  -- https://stackoverflow.com/questions/295052/how-can-i-determine-the-os-of-the-system-from-within-a-lua-script
  if ossep == '/' then
    -- *nix (MacOS, Linux) should have zip available
    print("Zipping reference.docx using UNIX zip.")
    os.execute ("cd " .. pandoc_data_dir .. "/reference && zip -r ../reference.docx * > /dev/null")
  elseif ossep == '\\' then
    -- Windows should have powershell
    print("Zipping reference.zip using PowerShell.")
    os.execute("powershell Compress-Archive -Path " .. pandoc_data_dir .. "\\reference\\* " .. pandoc_data_dir .. "\\reference.zip")
    print("Renaming reference.zip to reference.docx.")
    os.execute("powershell Rename-Item -Path " .. pandoc_data_dir .. "\\reference.zip -NewName ".. pandoc_data_dir .. "\\reference.docx")
  else
    print("Unknown shell: " .. ossep)
    os.exit(1)
  end
end

