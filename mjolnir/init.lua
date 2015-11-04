local hotkey = require "mjolnir.hotkey"
local alert  = require "mjolnir.alert"
local grid   = require "mjolnir.bg.grid"
local window = require "mjolnir.window"
local screen = require "mjolnir.screen"

-- Grid options

grid.GRIDHEIGHT = 2
grid.GRIDWIDTH  = 10
grid.MARGINX    = 5
grid.MARGINY    = 5

-- Context hotkey helpers

local context_hks = {}
local context_dir = 0

enable_context_hks = function()
  for i,hk in ipairs(context_hks) do
    hotkey.enable(hk)
  end
end

disable_context_hks = function()
  for i,hk in ipairs(context_hks) do
    hotkey.disable(hk)
  end
end

-- up and down hotkeys

up_hk = hotkey.bind({"ctrl", "alt", "cmd"}, "up", function()
  win = window.focusedwindow()
  if win then
    g = grid.get(win)
    g.y = 0
    g.h = 1
    grid.set(win, g, screen.mainscreen())
  end
end)

down_hk = hotkey.bind({"ctrl", "alt", "cmd"}, "down", function()
  win = window.focusedwindow()
  if win then
    g = grid.get(win)
    g.y = 1
    g.h = 1
    grid.set(win, g, screen.mainscreen())
  end
end)

-- left and right hotkeys

left_hk = hotkey.bind({"ctrl", "alt", "cmd"}, "left", function()
  alert.show("Grid \xE2\xAC\x85", 1)
  context_dir = 0
  enable_context_hks()
end)

right_hk = hotkey.bind({"ctrl", "alt", "cmd"}, "right", function()
  alert.show("Grid \xE2\x9E\xA1", 1)
  context_dir = 1
  enable_context_hks()
end)

-- escape hotkey

escape_hk = hotkey.new({}, "escape", function()
  alert.show("Grid cancelled", 1)
  disable_context_hks()
end)

context_hks[#context_hks + 1] = escape_hk

-- 0-9 hotkeys

for num = 0,9 do
  hk = hotkey.new({}, tostring(num), function()
    disable_context_hks()
    alert.show("Col " .. tostring(num), 1)
    win = window.focusedwindow()
    if win then
      x, y, w, h = 0, 0, grid.GRIDWIDTH, grid.GRIDHEIGHT
      if num > 0 then
        if context_dir == 0 then
          w = num
        else
          x = grid.GRIDWIDTH - num
          w = num
        end
      end
      grid.set(win, {x=x, y=y, w=w, h=h}, screen.mainscreen())
      grid.snap(win)
    end
  end)
  context_hks[#context_hks + 1] = hk
end

-- Mjolnir bits

hotkey.bind({"ctrl", "alt", "cmd"}, "R", function()
  mjolnir.reload()
end)

hotkey.bind({"ctrl", "alt", "cmd"}, "C", function()
  mjolnir.openconsole()
end)

alert.show("Mjolnir \xE2\x9C\x94", 1)
