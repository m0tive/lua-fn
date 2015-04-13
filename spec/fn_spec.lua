package.path = "./lib/?.lua;./lib/?/init.lua;./spec/?.lua;" .. package.path

local fn = require 'fn'
local math = require 'math'

require 'busted'

describe("funct", function()
  it("partially applies functions", function()
    local _add = function(a,b) return a+b end

    local _2plus = fn.funct.curry(_add, 2)
    assert.is_function(_2plus)
    assert.equal(5, _2plus(3))

    local _3plus = _add:curry(3)
    assert.is_function(_3plus)
    assert.equal(7, _3plus(4))

    local _4plus = _add/4
    assert.is_function(_4plus)
    assert.equal(9, _4plus(5))
  end)

  it("combine functions", function()
    local _mul = function(a,b) return a*b end
    local plus1 = function(a) return a + 1 end

    local bad_mult = fn.funct.compose(plus1, _mul)
    assert.is_function(bad_mult)
    assert.equal(7, bad_mult(2, 3))

    local bad_mult = plus1:compose(_mul)
    assert.is_function(bad_mult)
    assert.equal(9, bad_mult(2, 4))

    local bad_mult = plus1 .. _mul
    assert.is_function(bad_mult)
    assert.equal(11, bad_mult(2, 5))
  end)

  it("negates a function", function()
    local function istrue(v) return v and true or false end
    assert.equal(true, istrue(1))
    assert.equal(false, istrue(nil))

    local isnottrue = funct.negate(istrue)
    assert.is_function(isnottrue)
    assert.equal(false, isnottrue(1))
    assert.equal(true, isnottrue(nil))

    local isnottrue = istrue:negate()
    assert.is_function(isnottrue)
    assert.equal(false, isnottrue(1))
    assert.equal(true, isnottrue(nil))
  end)
end)
