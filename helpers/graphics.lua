styleStack = {}

g.pushStyle = function()
	table.insert(styleStack, Style:fromGraphics(g))
end

g.popStyle = function()
	lastStyle = table.remove(styleStack)
	g.setColor(lastStyle.color.r, lastStyle.color.g, lastStyle.color.b, lastStyle.color.a)
	g.setShader(lastStyle.shader)
end