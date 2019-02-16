-- Be sure to define a global vars = {}

function Meta(meta)
  for k, v in pairs(meta) do
    if v.t == "MetaInlines" then
      vars["#" .. k .. "#"] = pandoc.utils.stringify(v)
    end
  end
end

