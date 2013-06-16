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
	-- TODO: refactor for clarity
	local columnHeights = {}
	for i=1,self.data.width do
		columnHeights[i] = 0
	end

	for row=1,self.data.height do
		self.tiles[row] = {}
		for col=1,self.data.width do

			tileData = self:findTileDataFor(row, col, tileLayer)

			if tileData ~= 0 then
				columnHeights[col] = columnHeights[col] + 1
				self:addTile(row, col)

				if row == self.data.height and columnHeights[col] ~= 0 then
					self:addColumn(row, col, columnHeights)
				end
			else
				if columnHeights[col] ~= 0 then
					self:addColumn(row, col, columnHeights)
				end
				columnHeights[col] = 0
			end
		end
	end
end

function Map:addColumn(startRow, col, colliderTileHeights)
	local tilePosition = vector((col-1)*Tile.SIZE.x, (startRow-colliderTileHeights[col])*Tile.SIZE.y)
	local tileSize = vector(Tile.SIZE.x, Tile.SIZE.y*colliderTileHeights[col])

	local columnCollider = GameObject:new(self.world, tilePosition + tileSize/2, tileSize, nil)
	columnCollider.isLandscape = true
	table.insert(self.columnColliders, columnCollider)
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
		vector((col-1)*Tile.SIZE.x, (row-1)*Tile.SIZE.y))
end

-- UPDATE
function Map:update(dt)
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