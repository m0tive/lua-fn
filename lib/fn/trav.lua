-- Methods for traversing arrays

local funct = require 'fn.funct'
local fold = require 'fn.fold'

local trav = {}

-- elem (search)
function trav.elem(e, t)
  for _,v in ipairs(t) do
    if v == e then
      return true
    end
  end
  return false
end

-- map
function trav.map(f, t)
  local r = {}
  for k,v in ipairs(t) do
    r[k] = f(v)
  end
  return r
end

-- sum
-- product: foldl/op"*"

return trav
