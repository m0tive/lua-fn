require 'spec.setup'

local fold = require 'fn.fold'

describe("fold", function()
  it("can fold left over elements", function()
    local function _div(a,b) return a/b end
    assert.equal(2, fold.foldl(_div, 64, {4,2,4}))
    assert.equal(3, fold.foldl(_div, 3, {}))
  end)
  
  it("can fold right over elements", function()
    local function _div(a,b) return a/b end
    assert.equal(8, fold.foldr(_div, 2, {8,12,24,4}))
    assert.equal(3, fold.foldr(_div, 3, {}))
  end)

  it("can fold left over elements with no base", function()
    local function _add(a,b) return a+b end
    local function _div(a,b) return a/b end
    assert.equal(10, fold.foldl1(_add, {1,2,3,4}))
    assert.equal(1, fold.foldl1(_div, {64,4,2,8}))
    assert.equal(12, fold.foldl1(_div, {12}))
  end)

  it("can fold right over elements with no base", function()
    local function _add(a,b) return a+b end
    local function _div(a,b) return a/b end
    assert.equal(10, fold.foldr1(_add, {1,2,3,4}))
    assert.equal(4, fold.foldr1(_div, {8,12,24,4}))
    assert.equal(12, fold.foldr1(_div, {12}))
  end)

end)
