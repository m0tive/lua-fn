require 'spec.setup'

local trav = require 'fn.trav'

describe("trav", function()
  it("can search for elements", function()
    assert.equal(true, trav.elem(2, {4,3,2,1}))
    assert.equal(false, trav.elem(10, {4,3,2,1}))
    assert.equal(false, trav.elem(2, {}))
  end)
  
  it("can count up elements", function()
    assert.equal(4, trav.count({4,3,2,1}))
    assert.equal(0, trav.count({}))
  end)
  
  it("can map a function onto each element", function()
    assert.are.same({"4","3","2","1"}, trav.map(tostring, {4,3,2,1}))
  end)
  
  it("can add up all members", function()
    assert.equal(10, trav.sum({4,3,2,1}))
  end)
  
  it("can multiply all members", function()
    assert.equal(24, trav.product({4,3,2,1}))
  end)
end)
