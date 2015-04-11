require 'spec.setup'

local ops = require 'fn.ops'

describe("ops", function()
  it("can access op table as a function", function()
    assert.equal(ops.op["+"], ops.op"+")
  end)

  it("can call each operator", function()
    assert.equal(2+3, ops.op["+"](2,3))
    assert.equal(2+3, ops.add(2,3))

    assert.truthy(false) -- todo
  end)
end)
    
