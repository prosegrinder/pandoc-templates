-- http://pandoc.org/lua-filters.html
-- counts words in a document

word_count = 0

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

function format_word_count(amount)
  local formatted = string.format("%i", amount)
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

