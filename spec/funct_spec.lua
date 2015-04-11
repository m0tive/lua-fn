require 'spec.setup'

local funct = require 'fn.funct'
local math = require 'math'

describe("funct", function()
  it("partially applies functions", function()
    local _add = function(a,b) return a+b end

    local _2plus = funct.partial(_add, 2)
    assert.is_function(_2plus)
    assert.equal(5, _2plus(3))

    local _3plus = _add:partial(3)
    assert.is_function(_3plus)
    assert.equal(7, _3plus(4))

    local _4plus = _add/4
    assert.is_function(_4plus)
    assert.equal(9, _4plus(5))
  end)

  it("combine functions", function()
    local _mul = function(a,b) return a*b end
    local plus1 = function(a) return a + 1 end

    local bad_mult = funct.compose(plus1, _mul)
    assert.is_function(bad_mult)
    assert.equal(7, bad_mult(2, 3))

    local bad_mult = plus1:compose(_mul)
    assert.is_function(bad_mult)
    assert.equal(9, bad_mult(2, 4))

    local bad_mult = plus1 .. _mul
    assert.is_function(bad_mult)
    assert.equal(11, bad_mult(2, 5))
  end)
end)
