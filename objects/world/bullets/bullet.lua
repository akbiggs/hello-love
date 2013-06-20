-- CLASS
Bullet = class("objects.world.bullets.Bullet", GameObject)
Bullet:include(Collidable)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES

-- INITIALIZATION

-- TODO: this constructor is getting out of hand with arguments, consider
-- switching to passing an options table instead with some reasonable
-- default values
function Bullet:initialize(world, owner, position, size, texture, fireDirection, speed, collisionNoise)
	self.owner = owner
	self.direction = fireDirection
	self.speed = speed
	self.noise = collisionNoise

	GameObject.initialize(self, world, position, size, texture)
end

-- UPDATE
function Bullet:update(dt)
	local delta = self.direction * self.speed * dt
	self:translate(delta.x, delta.y)
end

-- COLLISIONS
function Bullet:collideWithLandscape()
	self:explode()
end

function Bullet:explode()
	self.world:generateSound(self.owner, self.position, self.noise)
	self.world:remove(self)
end

-- DRAW
function Bullet:draw()
	g.pushStyle(self.style)

	GameObject.draw(self)
	
	g.popStyle()
end
