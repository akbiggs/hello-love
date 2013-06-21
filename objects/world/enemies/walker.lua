-- CLASS
Walker = class("objects.world.enemies.Walker", Enemy)
Walker:include(Talker)
Walker:include(Stateful)

-- STATES

local Docile = Walker:addState("Docile")
local Warned = Walker:addState("Warned")
local Alert = Walker:addState("Alert")

-- STATIC PROPERTIES
Walker.static.SIZE = vector(32, 32)
Walker.static.DOCILE_SPEED = 100

-- LOCAL PROPERTIES

-- INITIALIZATION
function Walker:initialize(world, position)
	Enemy.initialize(self, world, position, Walker.SIZE, nil)
	self.direction = Direction.RIGHT
	self.isAlive = true

	self:gotoState("Docile")

	self.investigationPosition = nil
	self.lastKnownPlayerPosition = nil

	self.style = Style:new({
		color = Color:new(255, 0, 0, 255)
	})
end

-- UPDATE
function Walker:update(dt)
	Enemy.update(self, dt)
	self:walk(dt)
end

function Walker:walk(dt)
	self:translateX(dt * self.direction * Walker.DOCILE_SPEED)
end

function Walker:investigate(position)
	self.investigationPosition = position
end

function Walker:attack(position)
	self.lastKnownPlayerPosition = position
end

function Walker:die()
	self.world:remove(self)
end

-- COLLISIONS
function Walker:hitWall()
	self.direction = Direction.reverse(self.direction)
end

function Walker:collideWithBullet(bullet, dx, dy)
	self:die()
end

function Walker:collideWithSound(sound, dx, dy)
	if instanceOf(Player, sound.owner) then 
		source = sound.position
		if sound:isLoud() then
			self:alert(source)
		elseif sound:isQuiet() then
			self:warn(source)
		end
	end
end

-- STATE CHANGES
function Walker:calmDown()
	self.investigationPosition = nil
	self:gotoState("Docile")
end

function Walker:warn(source)
	self:investigate(source)
	self:gotoState("Warned")
end

function Walker:alert(source)
	self:attack(source)
	self:gotoState("Alert")
end

-- DOCILE
-- acts the same as the normal walker, I just felt like being explicit about
-- its state

-- WARNED
-- a bit suspicious. investigates source of the sound.
function Warned:update(dt)
	--self:lookAround(self.investigationPosition)
end

function Warned:warn(source)
	self:investigate(source)
end

-- ALERT
-- firing bullets and maybe throws a grenade. Hunting player.
function Alert:update(dt)
end

function Alert:warn(source)
	self:attack(source)
end

function Alert:alert(source)
	self:attack(source)
end

-- DRAW
function Walker:draw()
	g.pushStyle(self.style)

	Enemy.draw(self)
	
	g.popStyle()
end

function Docile:draw()
	self.style.color.g = 125
	Walker.draw(self)
end

function Warned:draw()
	self.style.color.g = 255
	Walker.draw(self)
end

function Alert:draw()
	self.style.color.g = 0
	Walker.draw(self)
end
