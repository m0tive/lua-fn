local ops = require 'fn.ops'

-- Add a metatable to the function object
local funct = {}
local functmt = { __index = funct }
debug.setmetatable(function() end, functmt)

-- Call the function
--
--   funct.call(myFunct, ...)
--   myFunct:call(...)
--
function funct:call(...)
  return self(...)
end

function funct:curry(x)
  return function(...) return self(x, ...) end
end

function funct:compose(f)
  return function(...) return self(f(...)) end
end

functmt.__div = funct.curry
functmt.__concat = funct.compose

funct.negate = funct.compose/ops.NOT

return funct
