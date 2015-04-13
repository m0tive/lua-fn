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
-- seq.rot (a,b,c) -> (b,c,a)

return seq
