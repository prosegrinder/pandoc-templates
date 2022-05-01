-- Be sure to define a global vars = {}

function Meta(meta)
  for k, v in pairs(meta) do
    if pandoc.utils.type(v) == "Inlines" then
      vars["#" .. k .. "#"] = pandoc.utils.stringify(v)
    end
  end
end

