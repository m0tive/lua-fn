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
end)
