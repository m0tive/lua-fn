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
    assert.equal(2==3, ops.eq(2==3))

    -- ops.ne
    -- ops.lt
    -- ops.gt
    -- ops.le
    -- ops.ge
    -- ops.concat
    -- ops.AND
    -- ops.OR
    -- ops.NOT
    -- ops.index
    -- ops.unm

    assert.truthy(false) -- todo
  end)
end)
    
