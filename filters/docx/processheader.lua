-- Inject vars into header and footers

function processHeaderFile(vars, pandoc_data_dir, headerFilename)
  local ossep = package.config:sub(1,1)

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
