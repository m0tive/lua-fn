--------------------------------------------------------------------------------
local fn = {}
fn.funct = require 'fn.funct'
fn.ops = require 'fn.ops'
fn.seq = require 'fn.seq'

function fn.FALSE() return false end
function fn.TRUE() return true end
function fn.NIL() return nil end



--------------------------------------------------------------------------------
-- generate a new function that returns the arguments
--
--     const(a)   --> f() = a
--     const(a,b) --> f() = a,b
--
function fn.const(a, ...)
  local n = select('#', ...)
  if n == 0 then
    return function() end
  elseif n == 1 then
    local arg = ...
    return function() return arg end
  else
    local args = {...}
    return function() return a, unpack(args, 1, n) end
  end
end

--------------------------------------------------------------------------------
-- generate a new function that takes a single argument
--
--     rcurry(f)     --> f'(x) = f(x)
--     rcurry(f,a)   --> f'(x) = f(x,a)
--     rcurry(f,a,b) --> f'(x) = f(x,a,b)
--
function fn.rcurry(f, ...)
  local n = select('#', ...)
  if n == 0 then
    return function(a) return f(a) end
  elseif n == 1 then
    local arg = ...
    return function(a) return f(a, arg) end
  else
    local args = {...}
    return function(a) return f(a, unpack(args, 1, n)) end
  end
end

--------------------------------------------------------------------------------
-- generate a new function that takes a single argument
--
--     curry(f)     --> f'(x) = f(x)
--     curry(f,a)   --> f'(x) = f(a,x)
--     curry(f,a,b) --> f'(x) = f(a,b,x)
--
function fn.curry(f, ...)
  local n = select('#', ...)
  if n == 0 then
    return function(a) return f(a) end
  elseif n == 1 then
    local arg = ...
    return function(a) return f(arg, a) end
  else
    local args = {...}
    return function(a) return f(swap(a, unpack(args, 1, n))) end
  end
end

--------------------------------------------------------------------------------
-- Composit two or more functions together, so
--
--     composit(f,g)   --> f'(...) = f(g(...))
--     composit(f,g,h) --> f'(...) = f(g(h(...)))
--
function fn.composit(f, g, ...)
  local n = select('#', ...)
  if n == 0 then
    return function(...) return f(g(...)) end
  else
    local inner_composit = fn.composit(g, ...)
    return function(...) return f(inner_composit(...)) end
  end
end

--------------------------------------------------------------------------------
-- Negate the return of a function
--
--     negate(f) --> f'(...) = not f(...)
--
fn.negate = fn.curry(fn.composit, fn.ops.NOT)

--------------------------------------------------------------------------------
-- Left-fold a binary function over an array of elements using ipairs
--
--     foldl(f,m,[a,b,c]) --> f(f(f(m,a),b),c)
--
function fn.foldl(m, t, f)
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
function fn.foldr(f, m, t)
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

return fn
