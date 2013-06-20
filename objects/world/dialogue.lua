-- IMPORTS
require "lib.middleclass"

-- CLASS
Dialogue = class("objects.world.Dialogue")

-- STATIC PROPERTIES

-- LOCAL PROPERTIES

-- INITIALIZATION
function Dialogue:initialize(world, owner, text, lifetime)
	self.id = assignID()
	self.world = world
	self.owner = owner
	self.position = owner.position
	self.text = text
	self.lifetime = lifetime

	self.style = {
		color = Color:new(255, 255, 255, 1)
	}
	self:show()
end

-- UPDATE
function Dialogue:update(dt)
	if self:finished() then
		self.world:remove(self)
	end
end

function Dialogue:show()
	tween(self.lifetime/8, self.position, {y = self.position.y - 50}, "linear", function()
		Timer.add(self.lifetime*(3/4), self:hide())
	end)
	tween(self.lifetime/8, self.style.color, {a = 255})
end

function Dialogue:hide()
	print("Hide")
	tween(self.lifetime/8, self.position, {y = self.position.y + 50})
	tween(self.lifetime/8, self.style.color, {a = 0})
end

function Dialogue:finished()
	return self.style.color.a == 0
end

-- DRAW
function Dialogue:draw()
	g.pushStyle(self.style)

	g.print(self.text, self.position.x, self.position.y)	
	
	g.popStyle()
end
