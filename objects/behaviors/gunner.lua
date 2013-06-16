Gunner = {
	gun = nil,
	
	changeGun = function(self, gunClass)
		self.gun = gunClass:attachedToObject(self)
	end;

	fireGun = function(self)
		self.gun:fireIfAble()
	end;
}