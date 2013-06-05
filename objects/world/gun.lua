-- IMPORTS
require "lib.middleclass"
vector = require "lib.hump.vector"

-- CLASS
Gun = class("objects.world.Gun", GameObject)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES
Gun.canFire = true

-- INITIALIZATION
function Gun:initialize(position, size, texture, reload_time, bulletClass)
	self.reload_time = reload_time
	self.bulletClass = bulletClass

	GameObject.initialize(self, position, size, texture)
end

-- UPDATE
function Gun:update(dt)
	GameObject.update(self, dt)
end

function Gun:fire()
	if ()
	return self.bulletClass:new(position, vector(10, 10))
end

function Gun:canFire()
	return self.canFire
end

-- DRAW
function Gun:draw()
	GameObject.draw()
end
