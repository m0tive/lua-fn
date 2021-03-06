local funct = require 'fn.funct'

local seq = {}

-- seq.fst
function seq.fst(a) return a end

-- seq.snd
function seq.snd(_,a) return a end

-- seq.nth
seq.nth = seq.fst..select

-- seq.flip (a,b,...) -> (b,a,...)
function seq.flip(a,b,...)
  local n = select('#', ...)

  if n == 0 and b == nil then
    return a
  else
    return b,a,...
  end
end

-- seq.rot (a,b,c) -> (b,c,a)
function seq.rot(a, ...)
  local n = select('#', ...)

  if n == 0 then
    return a
  elseif n == 1 then
    return ..., a
  else
    local args = {...}
    n = n+1
    args[n] = a
    return unpack(args, 1, n)
  end
end

return seq
