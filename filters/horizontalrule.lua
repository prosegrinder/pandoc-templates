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
