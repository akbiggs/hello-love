-- CLASS
Style = class("engine.Style")

-- LOCAL PROPERTIES

-- INITIALIZATION
function Style:initialize(options)
	self.color = options.color
	self.shader = options.shader
	self.lineWidth = options.lineWidth
	self.lineStyle = options.lineStyle
end

function Style.static:fromGraphics(graphics)
	local r, g, b, a = graphics.getColor()
	return Style:new({
		color = Color:new(r, g, b, a),
		shader = graphics.getShader(), 
		lineWidth = graphics.getLineWidth(),
		lineStyle = graphics.getLineStyle()
	})
end
