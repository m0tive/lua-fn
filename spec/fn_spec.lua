package.path = "./lib/?.lua;./lib/?/init.lua;./spec/?.lua;" .. package.path

require 'fn'

require 'busted'

describe("core suite", function()
  it("passes", function()
    assert.truthy(true)
  end)
end)
