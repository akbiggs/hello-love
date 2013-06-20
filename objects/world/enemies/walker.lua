-- CLASS
Walker = class("objects.world.enemies.Walker", Enemy)
Walker:include(Talker)

-- STATIC PROPERTIES
Walker.static.SIZE = vector(32, 64)
Walker.static.DOCILE_SPEED = 100

-- LOCAL PROPERTIES

-- INITIALIZATION
function Walker:initialize(world, position)
	Enemy.initialize(self, world, position, Walker.SIZE, nil)

	self.style = Style:new({
		color = Color:new(255, 0, 0, 255)
	})
end

-- UPDATE
function Walker:update(dt)
	Enemy.update(self, dt)
	self:walk(Direction.RIGHT, dt)
end

function Walker:walk(direction, dt)
	self:translateX(dt * direction * Walker.DOCILE_SPEED)
end

function Walker:die()
	self.world:remove(self)
end

-- COLLISIONS
function Walker:collideWithBullet(other, dx, dy)
	self:die()
end

function Walker:collideWithSound(other, dx, dy)
	if not self.alert then
		self:say("!!!!!", 20)
		self.alert = true
	end
end

-- DRAW
function Walker:draw()
	g.pushStyle(self.style)

	Enemy.draw(self)
	
	g.popStyle()
end
