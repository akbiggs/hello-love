-- CLASS
Sound = class("objects.world.Sound")

-- STATIC PROPERTIES
Sound.static.INITIAL_GROWTH_SPEED = 800
Sound.static.MIN_GROWTH_SPEED = 20
Sound.static.START_ALPHA = 150
Sound.static.SUBWAVE_SIZE_INCREMENT = 120
Sound.static.SUBWAVE_THRESHOLD = Sound.SUBWAVE_SIZE_INCREMENT + 20
Sound.static.SUBWAVE_INTERVAL = 0.1

-- LOCAL PROPERTIES

-- INITIALIZATION
function Sound:initialize(world, position, radius)
	self.id = assignID()
	self.world = world
	self.position = position

	self.maxRadius = radius
	self.curRadius = 1

	self.bbox = BBox(self, position, vector(self.curRadius, self.curRadius))

	self.style = Style:new({
		color = Color:new(0, 0, 127, Sound.START_ALPHA),
		shader = rainbowGlow, 
		lineWidth = 4
	})

	if self.maxRadius >= Sound.SUBWAVE_THRESHOLD then
		-- for a cool effect, put some more sound waves inside this sound wave.
		self:generateSubWaves()
	end
end

function Sound:generateSubWaves()
	Timer.add(0.1, self.world:add(self:generateSubWave()))
end

function Sound:generateSubWave()
	return Sound:new(self.world, self.position, self.maxRadius - Sound.SUBWAVE_SIZE_INCREMENT)
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
	local oldRadius = self.curRadius
	self.curRadius = self.curRadius + self:getGrowthSpeed() * dt

	-- scale bounding box to match new radius
	self.bbox:scale(math.max(self.curRadius/oldRadius, 1))
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
