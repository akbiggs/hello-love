-- CLASS
World = class("engine.World")

-- STATIC PROPERTIES

-- LOCAL PROPERTIES
World.gravity = vector(0, 400)

World.addBuffer = {}
World.removeBuffer = {}

World.map = nil

World.players = {}
World.bullets = {}
World.enemies = {}
World.sounds = {}

-- INITIALIZATION
function World:initialize()
	self:changeLevel("test")
	table.insert(self.players, Player:new(self, vector(200, 100)))
end

function World:changeLevel(levelName)
	self.map = Map:new(self, levelName)
end

-- OBJECT OPERATIONS

function World:generateSound(position, radius)
	table.insert(self.sounds, Sound:new(self, position, radius))
end

function World:add(object)
	table.insert(self.addBuffer, object)
end

function World:unbufferedAdd(object)
	table.insert(self:findGroup(object), object)
end

function World:remove(object)
	table.insert(self.removeBuffer, object) 
end

function World:unbufferedRemove(object)
	table.remove(self:findGroup(object), object)
end

function World:findGroup(object)
	if instanceOf(Bullet, object) then 
		return self.bullets
	elseif instanceOf(Player, object) then
		return self.players
	elseif instanceOf(Enemy, object) then 
		return self.enemies
	elseif instanceOf(Sound, object) then 
		return self.sounds
	end
end

-- UPDATE
function World:update(dt)
	self.map:update()

	self:updateGroup(self.players, dt)
	self:updateGroup(self.bullets, dt)
	self:updateGroup(self.enemies, dt)
	self:updateGroup(self.sounds, dt)

	self:flushBuffers()
end

function World:updateGroup(group, dt)
	__.each(group, function(object) object:update(dt) end)
end

function World:flushBuffers()
	__.each(self.addBuffer, self.unbufferedAdd)
	__.each(self.removeBuffer, self.unbufferedRemove)
end

-- DRAW
function World:draw()
	love.graphics.setShader(nil)
	self.map:draw()

	self:drawGroup(self.players)
	self:drawGroup(self.enemies)
	self:drawGroup(self.bullets)
	
	love.graphics.setShader(rainbowGlow)	
	self:drawGroup(self.sounds)
end

function World:drawGroup(group)
	__.each(group, function(object) object:draw() end)
end
