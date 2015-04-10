package.path = "./lib/?.lua;./lib/?/init.lua;./spec/?.lua;" .. package.path

local rerun = require 'rerun'

require 'busted'

describe("core suite", function()
  it("passes", function()
    Assert.truthy(true)
  end)
end)
