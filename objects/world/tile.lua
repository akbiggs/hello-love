vector = require "lib.hump.vector"
require "objects.base.gameobject"
require "lib.middleclass"

Tile = class("objects.world.Tile", GameObject)
Tile.static.size = vector(32, 32)

function Tile:initialize(world, position)
    GameObject.initialize(self, world, position, Tile.size, nil)
end

function Tile:update(dt)
	GameObject.update(self, dt)
end