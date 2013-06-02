require "lib.middleclass"
require "engine.bbox"
require "objects.behaviors.collidable"
local inspect = require "lib.inspect"

GameObject = class("objects.base.GameObject")
GameObject.should_draw_bbox = true

function GameObject:initialize(position, size, texture)
    self.texture = texture

    self.bbox = BBox(self, position - size/2, size)
end

function GameObject:getCenter()
    return self.bbox:center()
end

function GameObject:getX()
    x, _ = self:getCenter()
    return x
end

function GameObject:getY()
    _, y = self:getCenter()
    return y
end

function GameObject:update(dt)
end

function GameObject:moveTo(x, y)
    self.bbox:moveTo(x, y)
end

function GameObject:translate(dx, dy)
    self.bbox:moveTo(self:getX() + dx, self:getY() + dy)
end

function GameObject:translateX(delta)
    self:translate(delta, 0)
end

function GameObject:translateY(delta)
    self:translate(0, delta)
end

function GameObject:draw()
    if self.should_draw_bbox then
        self.bbox:draw("fill")
    end
end
