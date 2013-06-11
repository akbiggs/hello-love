-- CLASS
Sound = class("objects.world.Sound")

-- LOCAL PROPERTIES
Sound.fadeSpeed = 500
Sound.color = Color:new(0, 0, 127, 255)

-- INITIALIZATION
function Sound:initialize(world, position, radius)
	self.world = world
	self.position = position
	self.maxRadius = radius
	self.curRadius = 1
end

-- UPDATE
function Sound:update(dt)
	self:fade(dt)
	self:grow(dt)
end

function Sound:fade(dt)
	self.color.a = self.color.a - self.fadeSpeed * dt
	if self:fadedOut() then
		self.world:remove(self)
	end
end

function Sound:fadedOut()
	return self.color.a <= 0
end

function Sound:grow(dt)
	self.curRadius = self.curRadius + 50 * dt
end

-- DRAW
function Sound:draw()
	love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
	love.graphics.circle("line", self.position.x, self.position.y, self.curRadius, 100)
end
