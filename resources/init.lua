local oo = require 'oo'
local util = require 'util'
local vector = require 'vector'
local constant = require 'constant'

local Timer = require 'Timer'

local czor = world:create_object('Compositor')

function background()
   czor:clear_with_color(util.rgba(255,255,255,255))
end

function level_init()
   util.install_basic_keymap()
   world:gravity({0,0})

   local cam = stage:find_component('Camera', nil)
   cam:pre_render(util.fthread(background))

   local obj = world:create_go()
   obj:pos({screen_width/2, screen_height/2})
   obj:add_component('CTestDisplay', {w=128,h=128})
end
