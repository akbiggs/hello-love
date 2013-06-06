local vector = require "lib.hump.vector"
require "lib.middleclass"
require "objects.base.gameobject"
require "objects.behaviors.collidable"

PhysicsObject = class("objects.base.PhysicsObject", GameObject)
PhysicsObject:include(Collidable)

PhysicsObject.velocity = vector(0, 0)

function PhysicsObject:initialize(position, size, texture)
    GameObject.initialize(self, position, size, texture)
end

function PhysicsObject:update(world, dt)
    GameObject.update(self, world, dt)
    self:applyGravity(world, dt)
    self:applyVelocity(dt)
end

function PhysicsObject:applyGravity(world, dt)
    self.velocity.y = self.velocity.y + world.gravity.y * dt
end

function PhysicsObject:applyVelocity(dt)
    self:translateX(self.velocity.x * dt)
    self:translateY(self.velocity.y * dt)
end

function PhysicsObject:land(world)
    self.velocity.y = 0
    self:emitSound(world)
end

function PhysicsObject:bumpHead(world)
    self.velocity.y = 0
end

function PhysicsObject:hitWall(world)
    self.velocity.x = 0
end

function PhysicsObject:emitSound(world)
    
end

function PhysicsObject:draw()
    GameObject.draw(self)
end
