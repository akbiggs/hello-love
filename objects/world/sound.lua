-- CLASS
Sound = class("objects.world.Sound", GameObject)

-- STATIC PROPERTIES
Sound.static.INITIAL_GROWTH_SPEED = 800
Sound.static.MIN_GROWTH_SPEED = 20
Sound.static.START_ALPHA = 127
-- LOCAL PROPERTIES

-- INITIALIZATION
function Sound:initialize(world, position, radius)
	self.id = assignID()
	self.world = world
	self.position = position

	self.maxRadius = radius
	self.curRadius = 1

	self.style = Style:new({
		color = Color:new(0, 0, 127, Sound.START_ALPHA),
		shader = rainbowGlow, 
		lineWidth = 4
	})
end

-- UPDATE
function Sound:update(dt)
	self:fade(dt)
	self:grow(dt)
end

function Sound:fade(dt)
	self.style.color.a = math.lerp(Sound.START_ALPHA, 0, self.curRadius / self.maxRadius)
	if self:fadedOut() then
		self.world:remove(self)
	end
end

function Sound:fadedOut()
	return self.style.color.a <= 0
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
	g.pushStyle(self.style)

	g.circle("line", self.position.x, self.position.y, self.curRadius, 100)

	g.popStyle()
end
