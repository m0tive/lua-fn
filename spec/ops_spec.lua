require 'spec.setup'

local ops = require 'fn.ops'

describe("ops", function()
  it("can access op table as a function", function()
    assert.equal(ops.op["+"], ops.op"+")
  end)

  it("can call each operator", function()
    -- ops.add
    assert.equal(2+3, ops.op["+"](2,3))
    assert.equal(2+3, ops.add(2,3))

    -- ops.sub
    assert.equal(2-3, ops.op["-"](2,3))
    assert.equal(2-3, ops.sub(2,3))

    -- ops.mul
    assert.equal(2*3, ops.op["*"](2,3))
    assert.equal(2*3, ops.mul(2,3))
    
    -- ops.div
    assert.equal(2/3, ops.op["/"](2,3))
    assert.equal(2/3, ops.div(2,3))

    -- ops.mod
    assert.equal(3%2, ops.op["%"](3,2))
    assert.equal(3%2, ops.mod(3,2))

    -- ops.pow
    assert.equal(2^3, ops.op["^"](2,3))
    assert.equal(2^3, ops.pow(2,3))

    -- ops.len
    local t = {1,1,2,3,5,8,13}
    assert.equal(#t, ops.op["#"](t))
    assert.equal(#t, ops.len(t))
    
    -- ops.eq
    assert.equal(2==3, ops.op["=="](2,3))
    assert.equal(2==3, ops.eq(2,3))

    -- ops.ne
    assert.equal(2~=3, ops.op["~="](2,3))
    assert.equal(2~=3, ops.ne(2,3))

    -- ops.lt
    assert.equal(2<3, ops.op["<"](2,3))
    assert.equal(2<3, ops.le(2,3))

    -- ops.gt
    assert.equal(2>3, ops.op[">"](2,3))
    assert.equal(2>3, ops.gt(2,3))

    -- ops.le
    assert.equal(2<=3, ops.op["<="](2,3))
    assert.equal(2<=3, ops.le(2,3))

    -- ops.ge
    assert.equal(2>=3, ops.op[">="](2,3))
    assert.equal(2>=3, ops.ge(2,3))

    -- ops.concat
    assert.equal("a".."b", ops.op[".."]("a","b"))
    assert.equal("a".."b", ops.concat("a","b"))

    -- ops.AND
    assert.equal(true and 3, ops.op["and"](true, 3))
    assert.equal(true and 3, ops.AND(true,3))

    -- ops.OR
    assert.equal(true or 3, ops.op["or"](true,3))
    assert.equal(true or 3, ops.OR(true,3))

    -- ops.NOT
    assert.equal(not true, ops.op["not"](true))
    assert.equal(not true, ops.NOT(true))

    -- ops.index
    local t = {1,1,2,3,5,8,13}
    assert.equal(t[3], ops.op["[]"](3))
    assert.equal(t[3], ops.index(3))

    -- ops.unm
    assert.equal(-3, ops.op["-"](3))
    assert.equal(-3, ops.unm(3))
  end)
end)
    
