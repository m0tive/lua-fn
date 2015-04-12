local ops = {}

ops.op = {
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
  ["[]"] = function(a,b) return a[b] end,
}

setmetatable(ops.op, { __call = ops.op["[]"] })

function ops.unm(a) return -a end

ops.add = ops.op'+'
ops.sub = ops.op'-'
ops.mul = ops.op'*'
ops.div = ops.op'/'
ops.mod = ops.op'%'
ops.pow = ops.op'^'
ops.len = ops.op'#'
ops.eq = ops.op'=='
ops.ne = ops.op'~='
ops.lt = ops.op'<'
ops.gt = ops.op'>'
ops.le = ops.op'<='
ops.ge = ops.op'>='
ops.concat = ops.op'..'
ops.AND = ops.op'and'
ops.OR = ops.op'or'
ops.NOT = ops.op'not'
ops.index = ops.op'[]'

return ops
