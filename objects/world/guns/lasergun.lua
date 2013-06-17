-- CLASS
LaserRifle = class("objects.world.guns.LaserRifle", Gun)

-- STATIC PROPERTIES
LaserRifle.static.RELOAD_TIME = 0.25
LaserRifle.static.SIZE = vector(16, 16)
LaserRifle.static.NOISE = 300

-- LOCAL PROPERTIES
LaserRifle.property = value

-- INITIALIZATION
function LaserRifle:initialize(world, position)
	Gun.initialize(self, world, position, LaserRifle.SIZE, nil, LaserRifle.RELOAD_TIME, LaserRifle.NOISE, Laser)
end

function LaserRifle.static:attachedToObject(object)
	self.owner = object
	return LaserRifle:new(object.world, object.position)
end
