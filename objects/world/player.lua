require "lib.middleclass"
require "objects.base.physicsobject"
require "helpers.input"

vector = require "lib.hump.vector"
inspect = require "lib.inspect"

Player = class("objects.world.Player", PhysicsObject)
Player.static.size = vector(32, 32)

Player.static.left_keys = {"left", "A"}
Player.static.right_keys = {"right", "D"}
Player.static.jump_keys = {"up", "space"}

Player.numJumps = 0
Player.maxJumps = 1

function Player:initialize(position)
	PhysicsObject.initialize(self, position, Player.size, nil)
end

function Player:update(dt)
	if self.velocity.y > 50 then
		self:fall()
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

function Player:land()
	self.numJumps = 0
	PhysicsObject.land(self)
end

function Player:jump(dt)
	self.velocity.y = -450
	self.numJumps = self.numJumps + 1
end