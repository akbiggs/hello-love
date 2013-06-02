vector = require "lib.hump.vector"
require "lib.middleclass"
require "objects.base.gameobject"
require "objects.behaviors.collidable"

PhysicsObject = class("objects.base.PhysicsObject", GameObject)
PhysicsObject:include(Collidable)

PhysicsObject.velocity = vector(0, 0)

function PhysicsObject:initialize(position, size, texture)
    GameObject.initialize(self, position, size, texture)
end

function PhysicsObject:update(dt)
    GameObject.update(self, dt)
    self:applyGravity(dt)
    self:applyVelocity(dt)
end

function PhysicsObject:applyGravity(dt)
    self.velocity.y = self.velocity.y + 550 * dt
end

function PhysicsObject:applyVelocity(dt)
    self:translateX(self.velocity.x * dt)
    self:translateY(self.velocity.y * dt)
end

function PhysicsObject:land()
    self.velocity.y = 0
end

function PhysicsObject:bumpHead()
    self.velocity.y = 0
end

function PhysicsObject:hitWall()
    self.velocity.x = 0
end

function PhysicsObject:draw()
    GameObject.draw(self)
end
