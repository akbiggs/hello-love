require "engine.engine"
require "engine.map"
require "engine.world"
require "helpers.input"
lick = require "lib.lick"
local inspect = require "lib.inspect"
local vector = require "lib.hump.vector"

lick.reset = true

-- LOCALS
local world = nil

-- LOVE CALLBACKS
function love.load()
    world = World:new()   

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
    world:update(dt)
end 

function love.draw()
    love.graphics.setShader(effect)
    world:draw() 
end

function love.keyreleased(key)
    Input:onKeyReleased(key)
end
