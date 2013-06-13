-- CLASS
Player = class("objects.world.Player", PhysicsObject)

-- STATIC PROPERTIES
Player.static.size = vector(32, 32)

Player.static.leftKeys = {"left", "A"}
Player.static.rightKeys = {"right", "D"}
Player.static.jumpKeys = {"up", "space"}
Player.static.dashKeys = {"x"}

-- LOCAL PROPERTIES

-- INITIALIZATION
function Player:initialize(world, position)
	self.numJumps = 0
	self.maxJumps = 1

	-- TODO: abstract direction values into more clear variables
	self.lastDirection = 1

	self.normalSpeed = 300
	self.dashSpeed = 500
	self.fallSpeed = 50
	self.jumpSpeed = 350

	self.speed = self.normalSpeed
	self.dashTimer = nil

	-- TODO: get texture for player
	PhysicsObject.initialize(self, world, position, Player.size, nil)
end

-- UPDATE
function Player:update(dt)
	if self.velocity.y > self.fallSpeed then
		self:fall(dt)
	end

	if not self:isDashing() then
		self:reactToInput(dt)
	else
		if Input:anyKeyReleased(Player.dashKeys) then
			Timer.cancel(self.dashTimer)
			self:endDash()
		else
			self:move(self.lastDirection, dt)
		end
	end

	PhysicsObject.update(self, dt)
end

function Player:reactToInput(dt)
	if Input:anyKeyDown(Player.leftKeys) then
		self:moveLeft(dt)
	elseif Input:anyKeyDown(Player.rightKeys) then
		self:moveRight(dt)
	end

	if Input:anyKeyTapped(Player.dashKeys) then
		self:dash()
	end

	if Input:anyKeyTapped(Player.jumpKeys) and self.numJumps < self.maxJumps then
		self:jump(dt)
	end
end

-- MOVEMENT
function Player:moveLeft(dt)
	self.lastDirection = -1
	self:move(self.lastDirection, dt)
end

function Player:moveRight(dt)
	self.lastDirection = 1
	self:move(self.lastDirection, dt)
end

function Player:move(direction, dt)
	self:translateX(direction * self.speed * dt)
end

function Player:dash()
	self.speed = self.dashSpeed
	self.dashTimer = Timer.add(1, function() self:endDash() end)
end

function Player:endDash()
	self.speed = self.normalSpeed
end

function Player:isDashing()
	return self.speed > self.normalSpeed
end

function Player:fall(dt)
	self.numJumps = math.max(self.numJumps, 1)
end

function Player:land(world)
	self.numJumps = 0
	PhysicsObject.land(self, world)
end

function Player:jump(dt)
	self.velocity.y = -self.jumpSpeed
	self.numJumps = self.numJumps + 1
end

-- DRAW
