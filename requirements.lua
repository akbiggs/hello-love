g = love.graphics

-- LIB
require "lib.middleclass"
require "lib.stateful"

__ = require "lib.underscore"
lick = require "lib.lick"
inspect = require "lib.inspect"
Collider = require "lib.hardon"

vector = require "lib.hump.vector"
Timer = require "lib.hump.timer"

-- ENGINE
require "engine.effects"
require "engine.style"
require "engine.bbox"
require "engine.color"
require "engine.collisions"
require "engine.map"
require "engine.world"

-- HELPERS
require "helpers.input"
require "helpers.graphics"
require "helpers.math"

-- OBJECTS
require "objects.behaviors.collidable"
require "objects.base.gameobject"
require "objects.base.physicsobject"
require "objects.world.gun"
require "objects.world.player"
require "objects.world.tile"
require "objects.world.sound"

-- GLOBAL INITIALIZATIONS
HC = Collider(10, onCollide)
lick.reset = true

nextID = 0
function assignID()
	nextID = nextID + 1
	return nextID
end