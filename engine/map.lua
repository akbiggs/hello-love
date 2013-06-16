-- CLASS
Map = class("engine.Map")
Map.tiles = {}

-- INITIALIZATION
function Map:initialize(world, mapName)
	self.world = world
	self.data = loadMapFromFile(mapName)
	self.columnColliders = {}
	self:initializeTileMap()
end

function loadMapFromFile(mapName)
	return require ("maps." .. mapName)
end

function Map:initializeTileMap()
	tileLayer = self:getTileLayer()

	-- collision boxes are done by columns of tiles as opposed to
	-- on an individual basis to avoid collision errors
	local colliderTileHeights = {}
	for i=1,self.data.width do
		colliderTileHeights[i] = 0
	end

	for row=1,self.data.height do
		self.tiles[row] = {}
		for col=1,self.data.width do

			tileData = self:findTileDataFor(row, col, tileLayer)

			if tileData ~= 0 then
				colliderTileHeights[col] = colliderTileHeights[col] + 1
				self:addTile(row, col)

				if row == self.data.height and colliderTileHeights[col] ~= 0 then
					self:addColumn(row, col, colliderTileHeights)
				end
			else
				if colliderTileHeights[col] ~= 0 then
					self:addColumn(row, col, colliderTileHeights)
				end
				colliderTileHeights[col] = 0
			end
		end
	end
end

function Map:addColumn(startRow, col, colliderTileHeights)
	local tilePosition = vector((col-1)*Tile.size.x, (startRow-colliderTileHeights[col])*Tile.size.y)
	local tileSize = vector(Tile.size.x, Tile.size.y*colliderTileHeights[col])

	table.insert(self.columnColliders, GameObject:new(self.world, tilePosition + tileSize/2, 
		tileSize, nil))
end

-- TILE OPERATIONS
function Map:getTileLayer()
	return self.data.layers[1]
end

function Map:findTileDataFor(row, col, tileLayer)
	row_offset = (row-1)*self.data.width
	return tileLayer.data[row_offset + col]
end

function Map:addTile(row, col)
	self.tiles[row][col] = Tile:new(self.world, 
		vector((col-1)*Tile.size.x, (row-1)*Tile.size.y))
end

-- UPDATE
function Map:update(world, dt)
end

-- DRAW
function Map:draw()
	for i,row in pairs(self.tiles) do
		for j,tile in pairs(row) do
			--tile:draw()
		end
	end

	-- for now, draw the colliders before we have rendering the 
	-- tilemap working
	for k,collider in pairs(self.columnColliders) do
		collider:draw()
	end
end