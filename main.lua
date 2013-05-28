require "objects.world.player"
require "objects.world.tile"
require "engine.engine"

vector = require "lib.hump.vector"

-- LOCALS
local player = nil
local tile = nil

-- LOVE CALLBACKS
function love.load()
    player = Player:new(vector(100, 100))
    tile = Tile:new(vector(100, 500))
end

function love.update(dt)
    HC:update(dt)
    player:update(dt)
    tile:update(dt)
end

function love.draw()
    player:draw()
    tile:draw()
end
