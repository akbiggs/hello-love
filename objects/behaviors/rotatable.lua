Rotatable = {
	angle = 0,
	
	rotate = rotateRelative,
	
	rotateRelative = function(self, newAngle)
		self.angle = self.angle + newAngle
	end;

	rotateAbsolute = function(self, newAngle)
		self.angle = newAngle
	end
}