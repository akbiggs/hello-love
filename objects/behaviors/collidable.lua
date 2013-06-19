Collidable = {
	canCollide = true,
    collide = function(self, other, dx, dy)
    	if dx ~= 0 or dy ~= 0 then
	        if other.isLandscape then
	            self:collideWithLandscape(other, dx, dy)
	        end
        elseif instanceOf(Bullet, other) then
        	self:collideWithBullet(other, dx, dy)
    	end
    end;

    collideWithLandscape = function(self, other, dx, dy) end;
    collideWithBullet = function(self, other, dx, dy) end;
}
