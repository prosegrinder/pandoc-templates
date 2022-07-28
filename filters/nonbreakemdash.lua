-- Add a unicode "word joiner" (code point 2060) at the beginning of em dashes
--
-- Without this, lines in the docx can break just before an em dash, leaving
-- the em dash at the beginning of the next line.  The word joiner disallows
-- breaking the line between the preceding word and the em dash.

function Str(elem)
   -- Note that all instance of "—" below are an em dash, *not* a hyphen.  Be
   -- careful when editing.
   if string.find(elem.text, "—") then
	  return pandoc.Str(string.gsub(elem.text, "—", "\u{2060}—"))
   else
	  return elem
   end
end
