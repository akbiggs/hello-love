-- IMPORTS
require "lib.middleclass"

-- CLASS
Enemy = class("objects.world.enemies.Enemy", PhysicsObject)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES

-- INITIALIZATION
function Enemy:initialize(world, position, size, texture)
	PhysicsObject.initialize(self, world, position, size, texture)

	self.isAlive = true
	HC:addToGroup("enemies", self.bbox)
end

-- UPDATE
function Enemy:update(dt)
	if not self.isAlive then
		self.world:remove(self)
	else
		PhysicsObject.update(self, dt)
	end
end

-- DRAW
