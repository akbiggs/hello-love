Watcher = {
	range = 50,
	lookDuration = 20,
	lookPosition = nil,

	lookAt = function(self, spot)
		tween(lookDuration, self.lookPosition, spot)
	end;

	lookLeft = function(self, spot) 
		self:lookAt(vector(spot.x - 50, spot.y))
	end;

	lookRight = function(self, spot)
		self:lookAt(vector(spot.x + 50, spot.y))
	end;

	lookAbove = function(self, spot)
		self:lookAt(vector(spot.x, spot.y - 50))
	end;

	lookBelow = function(self, spot)
		self:lookAt(vector(spot.x, spot.y + 50))
	end;

	lookAround = function(self, spot)
		self:lookAt(spot)
		displacement = spot - self.position
		if math.abs(spot.x) >= math.abs(spot.y) then
			self:lookAroundVertically(spot)
		else
			self:lookAroundHorizontally(spot)
		end
	end;
	
	lookAroundHorizontally = function(self, spot) 
		firstDirection = Direction.random()
		timeVariance = math.random()
		if firstDirection == Direction.LEFT then
			Timer.add(1 + timeVariance, function() self:lookBelow(spot) end)
			Timer.add(2 + timeVariance, function() self:lookAbove(spot) end)
		else
			Timer.add(1 + timeVariance, function() self:lookAbove(spot) end)
			Timer.add(2 + timeVariance, function() self:lookBelow(spot) end)
		end
	end;

	lookAroundVertically = function(self, spot)
		firstDirection = Direction.random()
		timeVariance = math.random()
		if firstDirection == Direction.LEFT then
			Timer.add(1 + timeVariance, function() self:lookLeft(spot) end)
			Timer.add(2 + timeVariance, function() self:lookRight(spot) end)
		else
			Timer.add(1 + timeVariance, function() self:lookRight(spot) end)
			Timer.add(2 + timeVariance, function() self:lookLeft(spot) end)
		end
	end;
}