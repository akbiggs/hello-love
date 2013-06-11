Tile = class("objects.world.Tile", GameObject)
Tile.static.size = vector(32, 32)

function Tile:initialize(world, position)
    GameObject.initialize(self, world, position, Tile.size, nil)
end