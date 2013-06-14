-- IMPORTS
love.filesystem.load("requirements.lua")()

-- LOCALS
local world = nil

-- LOVE CALLBACKS
function love.load()
	love.window.setMode(1280, 800, {
		fullscreen = true
	})

    world = World:new()
end

function love.update(dt)
    HC:update(dt)
    Timer.update(dt)

    world:update(dt)
end 

function love.draw()
    world:draw()
end

function love.keyreleased(key)
    Input:onKeyReleased(key)
end
