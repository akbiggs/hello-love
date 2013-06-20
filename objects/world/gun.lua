-- CLASS
Gun = class("objects.world.Gun", GameObject)
Gun:include(Rotatable)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES
Gun.reloading = false
Gun.noise = 0

-- INITIALIZATION
function Gun:initialize(world, position, size, texture, reloadTime, noise, bulletClass)
	self.reloadTime = reloadTime
	self.bulletClass = bulletClass
	self.noise = noise

	GameObject.initialize(self, world, position, size, texture)
end

function Gun.static:attachedToObject(owner, size, texture, reloadTime, bulletClass)
	gun = Gun:new(owner.world, owner.position, size, texture, reloadTime, bulletClass)
	gun.owner = owner
	return gun
end

-- UPDATE
function Gun:update(dt)
	if self.owner then
		self:followOwner()
	end
	GameObject.update(self, dt)
end

function Gun:followOwner()
	self:moveTo(self.owner.position)
end

-- FIRING
function Gun:fire()
	self.world:add(self.bulletClass:new(self.world, self.owner, self.position, math.angleToDirection(self.angle)))
	self:reload()
	self.world:generateSound(self.owner, self.position, self.noise)
end

function Gun:fireIfAble()
	if self:canFire() then
		self:fire()
	end
end

function Gun:canFire()
	return not self.reloading
end

-- RELOADING
function Gun:reload()
	self.reloading = true
	Timer.add(self.reloadTime, function() self:finishReloading() end)
end

function Gun:finishReloading()
	self.reloading = false
end

-- DRAW
