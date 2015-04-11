package.path = "./lib/?.lua;./lib/?/init.lua;./spec/?.lua;" .. package.path

local fn = require 'fn'

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
end)
