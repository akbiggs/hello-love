styleStack = {}

-- STYLE OPERATIONS
g.pushStyle = function(style)
	table.insert(styleStack, Style:fromGraphics(g))
	g.setStyle(style)
end

g.popStyle = function()
	g.setStyle(table.remove(styleStack))
end

g.setStyle = function(style)
	if style.color then
		g.setColor(style.color)
	end

	if style.shader then
		g.setShader(style.shader)
	else
		g.setShader()
	end

	if style.lineWidth then
		g.setLineWidth(style.lineWidth)
	end

	if style.lineStyle then
		g.setLineStyle(style.lineStyle)
	end
end

-- COLOR OPERATIONS
g.setColorsIndividually = g.setColor

g.setColor = function(color)
	g.setColorsIndividually(color.r, color.g, color.b, color.a)
end