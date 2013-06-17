-- CLASS
Bullet = class("objects.world.bullets.Bullet", GameObject)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES

-- INITIALIZATION
function Bullet:initialize(world, position, size, texture, fireDirection, speed)
	self.direction = fireDirection
	self.speed = speed

	GameObject.initialize(self, world, position, size, texture)
end

-- UPDATE
function Bullet:update(dt)
	local delta = self.direction * self.speed * dt
	self:translate(delta.x, delta.y)
end

-- DRAW
function Bullet:draw()
	g.pushStyle(self.style)

	GameObject.draw(self)
	
	g.popStyle()
end
