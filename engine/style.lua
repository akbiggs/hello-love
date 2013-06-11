
-- CLASS
Style = class("engine.Style")

-- LOCAL PROPERTIES
Style.color = nil
Style.shader = nil

-- INITIALIZATION
function Style:initialize(color, shader)
	self.color = color
	self.shader = shader
end

function Style.static:fromGraphics(graphics)
	local r, g, b, a = graphics.getColor()
	return Style:new(Color:new(r, g, b, a), graphics.getShader())
end
