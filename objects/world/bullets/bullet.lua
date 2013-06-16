-- CLASS
Bullet = class("objects.world.bullets.Bullet", GameObject)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES

-- INITIALIZATION
function Bullet:initialize(world, position, size, texture, fireDirection)
	self.direction = fireDirection
	GameObject.initialize(self, world, position, size, texture)
end

-- UPDATE
function Bullet:update(dt)
	
end

-- DRAW
function Bullet:draw()
	g.pushStyle(self.style)

	GameObject.draw(self)
	
	g.popStyle()
end
