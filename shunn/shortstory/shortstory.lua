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

function Meta(meta)
  for k, v in pairs(meta) do
    if v.t == "MetaInlines" then
      vars["#" .. k .. "#"] = pandoc.utils.stringify(v)
    end
  end
  print("Unzipping")
  os.execute('./unziptemplate.sh')

  print("Processing")
  processHeaderFile('header2')
  processHeaderFile('header3')

  print("Zipping")
  os.execute ('./zipref.sh')
end

function HorizontalRule(el)
    return pandoc.RawBlock('openxml', hashrule)
end

function processHeaderFile(headerFilename)

  local tFilename = './template/word/' .. headerFilename .. '.xml'
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

  local dFilename = './docx/word/' .. headerFilename .. '.xml'
  local docxFile = io.open(dFilename,'w')
  docxFile:write(content)
  docxFile:close()
end


