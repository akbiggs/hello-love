nextID = 0

-- CLASS
GameObject = class("objects.base.GameObject")
GameObject.should_draw_bbox = true

-- STATIC PROPERTIES

-- LOCAL PROPERTIES

-- INITIALIZATION
function GameObject:initialize(world, center, size, texture)
    self.id = assignID()
    self.world = world
    self.position = center
    self.size = size
    self.bbox = BBox(self, center - size/2, size)
    self.texture = texture
end

-- POSITION GETTERS
function GameObject:getCenter()
    local x, y = self.bbox:center()
    return vector(x, y)
end

function GameObject:getBottom()
    return self:getCenter() + vector(0, self.size.y/2)
end

function GameObject:getX()
    return self:getCenter().x
end

function GameObject:getY()
    return self:getCenter().y
end

-- POSITION SETTERS
function GameObject:moveTo(position)
    self.position = position
    self.bbox:moveTo(position.x, position.y)
end

function GameObject:translate(dx, dy)
    self:moveTo(vector(self:getX() + dx, self:getY() + dy))
end

function GameObject:translateX(delta)
    self:translate(delta, 0)
end

function GameObject:translateY(delta)
    self:translate(0, delta)
end

-- UPDATE
function GameObject:update(dt)
end

-- DRAW
function GameObject:draw()
    if self.should_draw_bbox then
        self.bbox:draw("fill")
    end
end
