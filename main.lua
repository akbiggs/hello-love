require "objects.world.player"
require "objects.world.tile"
require "engine.engine"
require "engine.map"
require "helpers.input"
lick = require "lib.lick"
local inspect = require "lib.inspect"
local vector = require "lib.hump.vector"

lick.reset = true

-- LOCALS
local player = nil
local map = Map:new("test")

-- LOVE CALLBACKS
function love.load()
    player = Player:new(vector(200, 100))

    -- TESTING SHADERS
    effect = love.graphics.newShader [[
        vec4 effect(vec4 colour, Image img, vec2 txy, vec2 sxy)
        {
           return vec4(pow(cos((sxy.x-sxy.y)/20),2),pow(sin((sxy.y+sxy.x)/20),2),abs(1/(1+tan(length(sxy/20)))),1);
        }
    ]]
end

function love.update(dt)
    HC:update(dt)
    player:update(dt)
end 

function love.draw()
    love.graphics.setShader(effect)
    map:draw()
    player:draw()
end

function love.keyreleased(key)
    Input:onKeyReleased(key)
end
