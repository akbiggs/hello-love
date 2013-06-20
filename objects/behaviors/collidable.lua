Collidable = {
	canCollide = true,
    collide = function(self, other, dx, dy)
    	if dx ~= 0 or dy ~= 0 then
	        if other.isLandscape then
	            self:collideWithLandscape(other, dx, dy)
            elseif instanceOf(Bullet, other) then
            	self:collideWithBullet(other, dx, dy)
        	elseif instanceOf(Sound, other) then
                self:collideWithSound(other, dx, dy)
            end
        end
    end;

    collideWithLandscape = function(self, other, dx, dy) end;
    collideWithBullet = function(self, other, dx, dy) end;
    collideWithSound = function(self, other, dx, dy) end;
}
