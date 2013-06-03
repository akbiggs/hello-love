require "objects.world.player"
require "objects.world.tile"
require "engine.engine"
require "engine.map"
require "helpers.input"
inspect = require "lib.inspect"
vector = require "lib.hump.vector"

-- LOCALS
local player = nil
local map = Map:new("test")

local t = 0

-- LOVE CALLBACKS
function love.load()
    player = Player:new(vector(100, 100))

    -- TESTING SHADERS
    effect = love.graphics.newShader [[
        vec4 effect(vec4 colour, Image img, vec2 txy, vec2 sxy)
        {
           return vec4(pow(cos((sxy.x-sxy.y)/20),2),pow(sin((sxy.y+sxy.x)/20),2),abs(1/(1+tan(length(sxy/20)))),1);
        }
    ]]
    --effect:send("t", 0)
end

function love.update(dt)
    HC:update(dt)
    player:update(dt)

    t = t + math.min(dt, 1/30)
    --effect:send("t", t)
end

function love.draw()
    love.graphics.setShader(effect)
    map:draw()
    player:draw()
end

function love.keyreleased(key)
    Input.keyStates.down[key] = nil
end
