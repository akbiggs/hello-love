-- CLASS
Laser = class("objects.world.bullets.Laser", Bullet)
Laser:include(Rotatable)

-- STATIC PROPERTIES
Laser.static.SIZE = vector(16, 16)
Laser.static.SPEED = 1000
Laser.static.NOISE = 200

-- LOCAL PROPERTIES

-- INITIALIZATION
function Laser:initialize(world, position, fireDirection)
	Bullet.initialize(self, world, position, Laser.SIZE, nil, fireDirection, Laser.SPEED, Laser.NOISE)

	-- TODO: refactor this style crap into a separate style file
	self.style = Style:new({
		color = Color:new(255, 0, 0, 255)
	})
end

-- UPDATE

-- DRAW
