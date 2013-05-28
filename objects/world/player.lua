require "lib.middleclass"
require "objects.base.physicsobject"
require "helpers.inputhelper"

vector = require "lib.hump.vector"
inspect = require "lib.inspect"

Player = class("objects.world.Player", PhysicsObject)

Player.static.size = vector(32, 32)

Player.static.left_keys = {"left", "A"}
Player.static.right_keys = {"right", "D"}
Player.static.jump_keys = {"up", "space"}

Player.state = "fall"

function Player:initialize(position)
	PhysicsObject.initialize(self, position, Player.size, nil)
end

function Player:update(dt)
	if anyKeyDown(Player.left_keys) then
		self:moveLeft(dt)
	elseif anyKeyDown(Player.right_keys) then
		self:moveRight(dt)
	end

	if anyKeyDown(Player.jump_keys) then
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
	self:translateX(direction * 200 * dt)
end

function Player:jump(dt)
	-- TODO: fill this in
end