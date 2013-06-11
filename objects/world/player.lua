-- CLASS
Player = class("objects.world.Player", PhysicsObject)

-- STATIC PROPERTIES
Player.static.size = vector(32, 64)

Player.static.left_keys = {"left", "A"}
Player.static.right_keys = {"right", "D"}
Player.static.jump_keys = {"up", "space"}

-- LOCAL PROPERTIES
Player.numJumps = 0
Player.maxJumps = 1

-- INITIALIZATION
function Player:initialize(world, position)
	-- TODO: get texture for player
	PhysicsObject.initialize(self, world, position, Player.size, nil)
end

-- UPDATE
function Player:update(dt)
	if self.velocity.y > 50 then
		self:fall(dt)
	end

	if Input:anyKeyDown(Player.left_keys) then
		self:moveLeft(dt)
	elseif Input:anyKeyDown(Player.right_keys) then
		self:moveRight(dt)
	end

	if Input:anyKeyTapped(Player.jump_keys) and self.numJumps < self.maxJumps then
		self:jump(dt)
	end

	PhysicsObject.update(self, dt)
end

-- MOVEMENT
function Player:moveLeft(dt)
	self:move(-1, dt)
end

function Player:moveRight(dt)
	self:move(1, dt)
end

function Player:move(direction, dt)
	self:translateX(direction * 300 * dt)
end

function Player:fall(dt)
	self.numJumps = math.max(self.numJumps, 1)
end

function Player:land(world)
	self.numJumps = 0
	PhysicsObject.land(self, world)
end

function Player:jump(dt)
	self.velocity.y = -350
	self.numJumps = self.numJumps + 1
end

-- DRAW
