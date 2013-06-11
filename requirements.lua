g = love.graphics

-- LIB
require "lib.middleclass"
require "lib.stateful"
__ = require "lib.underscore"
lick = require "lib.lick"
inspect = require "lib.inspect"
vector = require "lib.hump.vector"
Collider = require "lib.hardon"

-- ENGINE
require "engine.effects"
require "engine.bbox"
require "engine.color"
require "engine.collisions"
require "engine.map"
require "engine.sound"
require "engine.world"

-- HELPERS
require "helpers.input"

-- OBJECTS
require "objects.behaviors.collidable"
require "objects.base.gameobject"
require "objects.base.physicsobject"
require "objects.world.gun"
require "objects.world.player"
require "objects.world.tile"

-- GLOBAL INITIALIZATIONS
HC = Collider(10, onCollide)
lick.reset = true

