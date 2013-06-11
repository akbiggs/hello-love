BBox = function(parent, position, size)
    box = HC:addRectangle(position.x, position.y, size.x, size.y)
    box.parent = parent
    return box
end
	