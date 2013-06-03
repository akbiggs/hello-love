-- IMPORTS
require "lib.middleclass"

-- CLASS
Gun = class("objects.world.Gun", GameObject)

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

-- TODO: implement fire and canFire
function Gun:fire()

end

function Gun:canFire()

end

-- DRAW
function Gun:draw()
	GameObject.draw()
end
