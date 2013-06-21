-- CLASS
Player = class("objects.world.Player", PhysicsObject)
Player:include(Gunner)

-- STATIC PROPERTIES
Player.static.SIZE = vector(16, 16)

Player.static.LEFT_KEYS = {"left", "A"}
Player.static.RIGHT_KEYS = {"right", "D"}
Player.static.JUMP_KEYS = {"up", "space", "z"}
Player.static.FIRE_KEYS = {"x"}
Player.static.DASH_KEYS = {"c"}

-- LOCAL PROPERTIES

-- INITIALIZATION
function Player:initialize(world, position)
	-- TODO: get texture for player
	PhysicsObject.initialize(self, world, position, Player.SIZE, nil)

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
	
	self:changeGun(LaserRifle)
end

-- UPDATE
function Player:update(dt)
	self:updateMovement(dt)
	self:updateGun(dt)

	PhysicsObject.update(self, dt)
end

function Player:updateMovement(dt)
	if self.velocity.y > self.fallSpeed then
		self:fall(dt)
	end

	if not self:isDashing() then
		self:reactToInput(dt)
	else
		if Input.anyKeyReleased(Player.DASH_KEYS) then
			self:endDash()
		else
			self:move(self.lastDirection, dt)
		end
	end
end

function Player:reactToInput(dt)
	if Input.anyKeyDown(Player.LEFT_KEYS) then
		self:moveLeft(dt)
	elseif Input.anyKeyDown(Player.RIGHT_KEYS) then
		self:moveRight(dt)
	end

	if Input.anyKeyTapped(Player.DASH_KEYS) then
		self:dash()
	end

	if Input.anyKeyTapped(Player.JUMP_KEYS) and self.numJumps < self.maxJumps then
		self:jump(dt)
	elseif self:isJumping() and Input.allKeysReleased(Player.JUMP_KEYS) then
		self.velocity.y = math.max(self.velocity.y, -100)
	end
end

function Player:updateGun(dt)
	self.gun:update(dt)
	self.gun:rotateAbsolute(math.getAngle(love.mouse.getPosition(), self.position))
	self.gun:rotateAbsolute(math.getAngle(self.position, love.mouse.getPosition()))

	if Input.anyKeyDown(Player.FIRE_KEYS) then
		self:fireGun()
	end
end

-- BASIC MOVEMENT
function Player:moveLeft(dt)
	self.lastDirection = Direction.LEFT
	self:move(self.lastDirection, dt)
end

function Player:moveRight(dt)
	self.lastDirection = Direction.RIGHT
	self:move(self.lastDirection, dt)
end

function Player:move(direction, dt)
	self:translateX(direction * self.speed * dt)
end

-- DASHING
function Player:dash(dt)
	self.speed = self.dashSpeed
	self.dashTimer = Timer.add(1, function() self:endDash() end)
end

function Player:endDash()
	if self.dashTimer then
		Timer.cancel(self.dashTimer)
	end
	self.speed = self.normalSpeed
end

function Player:isDashing()
	return self.speed > self.normalSpeed
end

-- AERIAL MOVEMENT
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

function Player:isJumping()
	return self.velocity.y < 0
end

-- DRAW
