require "lib.middleclass"

Collidable = {
	canCollide = true,
    collide = function(self, other, dx, dy)
        self:moveTo(self:getX() + dx, self:getY())
    end
}
