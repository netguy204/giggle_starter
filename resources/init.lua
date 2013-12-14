local oo = require 'oo'
local util = require 'util'
local vector = require 'vector'
local constant = require 'constant'

local Timer = require 'Timer'
local Rect = require 'Rect'

local czor = game:create_object('Compositor')

function background()
   czor:clear_with_color(util.rgba(255,255,255,255))
end

function solid_mesh(points, color)
   local mesh = game:create_object('Mesh')
   for ii = 1,#points,2 do
      mesh:add_point({points[ii], points[ii+1]}, color)
   end
   return mesh
end

function init()
   util.install_basic_keymap()
   world:gravity({0,0})

   local cam = stage:find_component('Camera', nil)
   cam:pre_render(util.fthread(background))

   local obj = world:create_go()
   local screen_rect = Rect(camera:viewport())
   obj:pos({screen_rect:width()/2, screen_rect:height()/2})

   local mesh = solid_mesh({100, -100,  0, 100,  -100, -100}, {1,0,1,1})
   obj:add_component('CMesh', {mesh=mesh, layer=constant.PLAYER})
end

function game_init()
   util.protect(init)()
end
