--------------------------------------------------------------------------------
local fn = {}

--------------------------------------------------------------------------------
fn.op = {
  ["+"] = function(a,b) return a + b end,
  ["-"] = function(a,b) return a - b end,
  ["*"] = function(a,b) return a * b end,
  ["/"] = function(a,b) return a / b end,
  ["%"] = function(a,b) return a % b end,
  ["^"] = function(a,b) return a ^ b end,
  ["#"] = function(a) return #a end,
  ["=="] = function(a,b) return a == b end,
  ["~="] = function(a,b) return a ~= b end,
  ["<="] = function(a,b) return a <= b end,
  [">="] = function(a,b) return a >= b end,
  ["<"] = function(a,b) return a < b end,
  [">"] = function(a,b) return a > b end,
  [".."] = function(a,b) return a .. b end,
  ["and"] = function(a,b) return (a and b) end,
  ["or"] = function(a,b) return (a or b) end,
  ["not"] = function(a) return (not a) end,
}

function fn.unm(a) return -a end

fn.add = fn.op['+']
fn.sub = fn.op['-']
fn.mul = fn.op['*']
fn.div = fn.op['/']
fn.mod = fn.op['%']
fn.pow = fn.op['^']
fn.len = fn.op['#']
fn.eq = fn.op['==']
fn.lt = fn.op['<']
fn.le = fn.op['<=']
fn.concat = fn.op['..']
fn.AND = fn.op['and']
fn.OR = fn.op['or']
fn.NOT = fn.op['not']

function fn.FALSE() return false end
function fn.TRUE() return true end
function fn.NIL() return nil end

--------------------------------------------------------------------------------
-- select first argument
--
--     first(a,b,c) --> a
--
function fn.first(a) return a end

--------------------------------------------------------------------------------
-- select second argument
--
--     second(a,b,c) --> b
--
function fn.second(_, a) return a end

--------------------------------------------------------------------------------
-- select last argument
--
--     last(a,b,c) --> c
--
function fn.third(_, _, a) return a end

--------------------------------------------------------------------------------
-- select n-th argument
--
--     nth(2,a,b,c) --> b
--
function fn.nth(n, ...) return first(select(n, ...)) end

--------------------------------------------------------------------------------
-- select last argument
--
--     last(a,b,c,d)   --> d
--     last(a,b,c,d,e) --> e
--
function fn.last(...) return select(select('#', ...), ...) end

--------------------------------------------------------------------------------
-- flip order of arguments
--
--     flip(a,b)     --> b,a
--     flip(a,b,c)   --> c,b,a
--     flip(a,b,c,d) --> d,c,b,a
--
function fn.flip(...)
  local n = select('#', ...)

  if n == 0 then
    return
  elseif n == 1 then
    return unpack(...)
  else
    local args = {...}
    local result = {}
    for i=1, n do
      result[i] = args[n - i + 1]
    end

    return unpack(result, 1, n)
  end
end

--------------------------------------------------------------------------------
-- make the first argument the last argument
--
--     swap(a,b)     --> b,a
--     swap(a,b,c)   --> b,c,a
--     swap(a,b,c,d) --> b,c,d,a
--
function fn.swap(a, ...)
  local n = select('#', ...)

  if n == 0 then
    return a
  elseif n == 1 then
    return unpack(...), a
  else
    local args = {...}
    args[n + 1] = a
    return unpack(args, 1, n+1)
  end
end

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
fn.negate = fn.curry(fn.composit, fn.op['not'])

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
