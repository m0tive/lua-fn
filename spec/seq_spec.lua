require 'spec.setup'

local seq = require 'fn.seq'

describe("seq", function()
  it("can get 1st item", function()
    assert.are.same({3}, {seq.fst(3,4,5,6)})
    assert.are.same({}, {seq.snd()})
  end)
  
  it("can get 2nd item", function()
    assert.are.same({4}, {seq.snd(3,4,5,6)})
    assert.are.same({}, {seq.snd(3)})
  end)
  
  it("can get nth item", function()
    assert.are.same({6}, {seq.nth(4, 3,4,5,6)})
    assert.are.same({}, {seq.nth(10, 3,4,5,6)})
  end)

  it("can flip item order", function()
    assert.are.same({4,3,5,6}, {seq.flip(3,4,5,6)})
    assert.are.same({4,3}, {seq.flip(3,4)})
    assert.are.same({3}, {seq.flip(3)})
    assert.are.same({}, {seq.flip()})
  end)

  it("can rotate item order", function()
    assert.are.same({4,5,6,3}, {seq.rot(3,4,5,6)})
    assert.are.same({4,3}, {seq.rot(3,4)})
    assert.are.same({3}, {seq.rot(3)})
    assert.are.same({}, {seq.rot()})
  end)
end)
