-- CLASS
Color = class("engine.Color")

-- STATIC PROPERTIES
Color.static.RED = Color:new(255, 0, 0, 255)
Color.static.GREEN = Color:new(0, 255, 0, 255)
Color.static.BLUE = Color:new(0, 0, 255, 0)

-- LOCAL PROPERTIES

-- INITIALIZATION
function Color:initialize(r, g, b, a)
	self.r = r
	self.g = g
	self.b = b
	self.a = a
end
