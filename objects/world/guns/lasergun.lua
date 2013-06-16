-- CLASS
LaserRifle = class("objects.world.guns.LaserRifle", Gun)

-- STATIC PROPERTIES
LaserRifle.static.RELOAD_TIME = 1
LaserRifle.static.SIZE = vector(16, 16)

-- LOCAL PROPERTIES
LaserRifle.property = value

-- INITIALIZATION
function LaserRifle:initialize(world, position)
	Gun.initialize(self, world, position, LaserRifle.SIZE, nil, LaserRifle.RELOAD_TIME, Laser)
end

function LaserRifle.static:attachedToObject(object)
	self.owner = object
	return LaserRifle:new(object.world, object.position)
end
