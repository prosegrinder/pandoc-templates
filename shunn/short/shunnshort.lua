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
  local data_dir = os.getenv('PANDOC_DATA_DIR')
  local tFilename = data_dir .. '/template/word/' .. headerFilename .. '.xml'
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

  local rFilename = data_dir .. '/reference/word/' .. headerFilename .. '.xml'
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

function Pandoc(doc, meta)

  pandoc.walk_block(pandoc.Div(doc.blocks), wordcount)

  vars["#word_count#"] = string.format("%i", round(word_count, -2))

  -- Process header XML files
  processHeaderFile('header2')
  processHeaderFile('header3')

  -- Generate reference.reference file
  os.execute ('cd $PANDOC_DATA_DIR/reference && zip -r ../reference.docx * > /dev/null')
end

