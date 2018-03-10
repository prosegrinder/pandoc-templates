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

function HorizontalRule(el)
    return pandoc.RawBlock('openxml', hashrule)
end

function copyTemplateFile(templateFilename)
  -- h1file = io.open('./template/word/header2.xml','r')
  local tFilename = './template/word/' .. templateFilename .. '.xml'
  print(tFilename)
  local h1file = io.open(tFilename,'r')
  local h1content = h1file:read("*a")
  h1file:close()
  local h1docx = io.open('./docx/word/' .. templateFilename,'w')
  content = string.gsub(h1content, '#last_name#', 'Day')
  content = string.gsub(content, ' #short_title#', 'Success')
  h1docx:write(content)
  h1docx:close()
end

os.execute('./unziptemplate.sh')

copyTemplateFile('header2')
copyTemplateFile('header3')

os.execute ('./zipref.sh')
