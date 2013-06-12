-- CLASS
Sound = class("objects.world.Sound", GameObject)

-- STATIC PROPERTIES
Sound.static.INITIAL_GROWTH_SPEED = 400
Sound.static.MIN_GROWTH_SPEED = 20

-- LOCAL PROPERTIES

-- INITIALIZATION
function Sound:initialize(world, position, radius)
	self.id = assignID()
	self.world = world
	self.position = position

	self.maxRadius = radius
	self.curRadius = 1

	self.color = Color:new(0, 0, 127, 255)
end

-- UPDATE
function Sound:update(dt)
	self:fade(dt)
	self:grow(dt)
end

function Sound:fade(dt)
	self.color.a = math.lerp(255, 0, self.curRadius / self.maxRadius)
	if self:fadedOut() then
		self.world:remove(self)
	end
end

function Sound:fadedOut()
	return self.color.a <= 0
end

function Sound:grow(dt)
	self.curRadius = self.curRadius + self:getGrowthSpeed() * dt
end

function Sound:getGrowthSpeed()
	return math.lerp(Sound.INITIAL_GROWTH_SPEED, Sound.MIN_GROWTH_SPEED, 
		self.curRadius / self.maxRadius)
end

-- DRAW
function Sound:draw()
	g.pushStyle()

	love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
	love.graphics.setShader(rainbowGlow)
	love.graphics.circle("line", self.position.x, self.position.y, self.curRadius, 100)

	g.popStyle()
end
