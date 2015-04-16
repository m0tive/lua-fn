require 'spec.setup'

local fold = require 'fn.fold'

local function _add(a,b) return a+b end
local function _div(a,b) return a/b end
local function _or(a,b) return a or b end

describe("fold", function()
  it("can fold left over elements", function()
    assert.equal(2, fold.foldl(_div, 64, {4,2,4}))
    assert.equal(3, fold.foldl(_div, 3, {}))
    assert.equal(true, fold.foldl(_or, true, {false,true,false,true}))
  end)
  
  it("can fold right over elements", function()
    assert.equal(8, fold.foldr(_div, 2, {8,12,24,4}))
    assert.equal(3, fold.foldr(_div, 3, {}))
    assert.equal(true, fold.foldr(_or, true, {false,true,false,true}))
  end)

  it("can fold left over elements with no base", function()
    assert.equal(10, fold.foldl1(_add, {1,2,3,4}))
    assert.equal(1, fold.foldl1(_div, {64,4,2,8}))
    assert.equal(12, fold.foldl1(_div, {12}))
    assert.equal(true, fold.foldl1(_or, {false,true,false,true}))
  end)

  it("can fold right over elements with no base", function()
    assert.equal(10, fold.foldr1(_add, {1,2,3,4}))
    assert.equal(4, fold.foldr1(_div, {8,12,24,4}))
    assert.equal(12, fold.foldr1(_div, {12}))
    assert.equal(true, fold.foldr1(_or, true, {false,true,false,true}))
  end)

end)
