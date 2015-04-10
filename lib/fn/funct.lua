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

return funct
