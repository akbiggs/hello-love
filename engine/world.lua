-- IMPORTS
require "lib.middleclass"
require "objects.world.player"
require "engine.map"
local vector = require "lib.hump.vector"
local inspect = require "lib.inspect"
-- CLASS
World = class("engine.World")

-- STATIC PROPERTIES

-- LOCAL PROPERTIES
World.gravity = vector(0, 400)

World.bullets = {}
World.player = nil
World.enemies = {}
World.map = nil

-- INITIALIZATION
function World:initialize()
	self:changeLevel("test")
	self.player = Player:new(vector(200, 100))
end

function World:changeLevel(levelName)
	self.map = Map:new(levelName)
end

-- UPDATE
function World:update(dt)
	self:updateMap(dt)
	self:updatePlayer(dt)
	self:updateBullets(dt)
	self:updateEnemies(dt)
end

function World:updateMap(dt)
	self.map:update(self, dt)
end

function World:updatePlayer(dt)
	self.player:update(self, dt)
end

function World:updateBullets(dt)
	for i,bullet in ipairs(self.bullets) do
		bullet:update(self, dt)
	end
end

function World:updateEnemies(dt)
	for i,enemy in ipairs(self.enemies) do
		enemy:update(self, dt)
	end
end

-- DRAW
function World:draw()
	self.map:draw()
	self.player:draw()
	self:drawEnemies()
	self:drawBullets()
end

function World:drawEnemies()
	for i,enemy in ipairs(self.enemies) do
		enemy:draw()
	end
end

function World:drawBullets()
	for i,bullet in ipairs(self.bullets) do
		bullet:draw()
	end
end