-- CLASS
PhysicsObject = class("objects.base.PhysicsObject", GameObject)
PhysicsObject:include(Collidable)

-- STATIC PROPERTIES

-- LOCAL PROPERTIES
PhysicsObject.velocity = vector(0, 0)

-- INITIALIZATION
function PhysicsObject:initialize(world, position, size, texture)
    GameObject.initialize(self, world, position, size, texture)
end

-- UPDATE
function PhysicsObject:update(dt)
    GameObject.update(self, dt)
    self:applyGravity(dt)
    self:applyVelocity(dt)
end

function PhysicsObject:applyGravity(dt)
    self.velocity.y = self.velocity.y + self.world.gravity.y * dt
end

function PhysicsObject:applyVelocity(dt)
    self:translateX(self.velocity.x * dt)
    self:translateY(self.velocity.y * dt)
end

-- COLLISIONS
function PhysicsObject:land()
    if self.velocity.y > 20 then
        self:emitSound(self.velocity.y/2)
    end
    self.velocity.y = 0
end

function PhysicsObject:bumpHead()
    self.velocity.y = 0
end

function PhysicsObject:hitWall()
    self.velocity.x = 0
end

function PhysicsObject:emitSound(loudness)
    self.world:generateSound(self:getBottom(), loudness)
end

-- DRAW

