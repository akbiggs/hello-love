Collidable = {
	canCollide = true,
    collide = function(self, other, dx, dy)
        if self.canCollide then
            self:translate(dx, dy)

            if dy < 0 and self.velocity.y > 0 then
            	self:land()
        	elseif dy > 0 and self.velocity.y < 0 then
        		self:bumpHead()
        	end

    	    if dx ~= 0 then
    	    	self:hitWall()
    	    end
        end
    end
}
