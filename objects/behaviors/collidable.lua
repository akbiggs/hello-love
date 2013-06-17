Collidable = {
	canCollide = true,
    collide = function(self, other, dx, dy)
        if other.isLandscape and (dx ~= 0 or dy ~= 0) then
            self:collideWithLandscape(dx, dy)
        end
    end;

    collideWithLandscape = function(self, dx, dy) end;
}
