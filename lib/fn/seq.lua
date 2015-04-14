local funct = require 'fn.funct'

local seq = {}

-- seq.id
function seq.id(...) return ... end

-- seq.fst
function seq.fst(a) return a end

-- seq.snd
function seq.snd(_,a) return a end

-- seq.nth
seq.nth = seq.first..select

-- seq.flip (a,b,...) -> (b,a,...)
function seq.flip(a,b,...) return b,a,... end

-- seq.rot (a,b,c) -> (b,c,a)
function fn.rot(a, ...)
  local n = select('#', ...)

  if n == 0 then
    return a
  elseif n == 1 then
    return unpack(...), a
  else
    local args = {...}
    n = n+1
    args[n] = a
    return unpack(args, 1, n)
  end
end

return seq
