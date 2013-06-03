require "lib.middleclass"
require "objects.world.tile"
local vector = require "lib.hump.vector"

Map = class("engine.Map")
Map.tiles = {}

function Map:initialize(mapName)
	self.data = loadMapFromFile(mapName)
	self:initializeTileMap()
end

function loadMapFromFile(mapName)
	return require ("maps." .. mapName)
end

function Map:initializeTileMap()
	tileLayer = self:getTileLayer()
	for row=1,self.data.height do
		self.tiles[row] = {}
		for col=1,self.data.width do
			tileData = self:findTileDataFor(row, col, tileLayer)
			if tileData ~= 0 then
				print("Adding tile at: " .. tostring(col))
				self:addTile(row, col)
			end
		end
	end
end

function Map:getTileLayer()
	return self.data.layers[1]
end

function Map:findTileDataFor(row, col, tileLayer)
	row_offset = (row-1)*self.data.width
	return tileLayer.data[row_offset + col]
end

function Map:addTile(row, col)
	self.tiles[row][col] = Tile:new(vector((col-1)*Tile.size.x, (row-1)*Tile.size.y))
end

function Map:update()
end

function Map:draw()
	for i,row in pairs(self.tiles) do
		for j,tile in pairs(row) do
			tile:draw()
		end
	end
end