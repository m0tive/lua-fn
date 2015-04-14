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

function funct:partial(x)
  return function(...) return self(x, ...) end
end

function funct.compose(f,g)
  if type(f) ~= "function" or type(g) ~= "function" then
    return error("cannot compose function with non-function")
  end
  
  return function(...) return f(g(...)) end
end

functmt.__div = funct.partial
functmt.__concat = funct.compose

funct.negate = funct.compose/ops.NOT

return funct
