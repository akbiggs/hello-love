-- IMPORTS
require "lib.middleclass"

-- CLASS
Enemy = class("objects.world.enemies.Enemy", PhysicsObject)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES

-- INITIALIZATION
function Enemy:initialize(world, position, size, texture)
	PhysicsObject.initialize(self, world, position, size, texture)

	self.shouldRemove = false
	HC:addToGroup("enemies", self.bbox)
end

-- UPDATE

-- DRAW
