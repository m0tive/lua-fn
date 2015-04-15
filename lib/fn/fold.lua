-- Folds

local fold = {}

--------------------------------------------------------------------------------
-- Left-fold a binary function over an array of elements using ipairs
--
--     foldl(f,m,[a,b,c]) --> f(f(f(m,a),b),c)
--
function fold.foldl(f, m, t)
  local m = m
  for _, v in ipairs(t) do
    m = f(m, v)
  end
  return m
end

--------------------------------------------------------------------------------
-- Right-fold a binary function over an array of elements using ipairs
--
--     foldr(f,m,[a,b,c]) --> f(a,f(b,f(c,m)))
--
function fold.foldr(f, m, t)
  local iter, _, start = ipairs(t)

  function caller(m, i)
    local i, v = iter(t, i)
    if v == nil then
      return m
    else
      return f(v, caller(m, i))
    end
  end

  return caller(m, start)
end

return fold
