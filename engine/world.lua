-- CLASS
World = class("engine.World")

-- STATIC PROPERTIES

-- LOCAL PROPERTIES
World.gravity = vector(0, 500)

World.addBuffer = {}
World.removeBuffer = {}

World.map = nil

World.players = {}
World.bullets = {}
World.enemies = {}
World.sounds = {}

-- INITIALIZATION
function World:initialize()
	self:changeLevel("level1")
	self:add(Player:new(self, vector(200, 100)))
end

function World:changeLevel(levelName)
	self.map = Map:new(self, levelName)
end

-- OBJECT OPERATIONS
function World:generateSound(position, radius)
	self:add(Sound:new(self, position, radius))
end

-- a normal operation will wait until the end of the update
-- cycle before executing, an unbuffered will not. Prevents
-- adding/removing objects while iterating.
function World:add(object)
	table.insert(self.addBuffer, object)
end

function World:unbufferedAdd(object)
	self:findGroup(object)[object.id] = object
end

function World:remove(object)
	table.insert(self.removeBuffer, object) 
end

function World:unbufferedRemove(object)
	self:findGroup(object)[object.id] = nil
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
	for id,object in pairs(group) do
		object:update(dt)
	end
end

function World:flushBuffers()
	__.each(self.addBuffer, function(object) self:unbufferedAdd(object) end)
	__.each(self.removeBuffer, function(object) self:unbufferedRemove(object) end)

	self.addBuffer = {}
	self.removeBuffer = {}
end

-- DRAW
function World:draw()
	self.map:draw()

	self:drawGroup(self.players)
	self:drawGroup(self.enemies)
	self:drawGroup(self.bullets)
	self:drawGroup(self.sounds)
end

function World:drawGroup(group)
	for id,object in pairs(group) do
		object:draw()
	end
end
