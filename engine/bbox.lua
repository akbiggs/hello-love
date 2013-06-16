BBox = function(parentObject, position, size)
    box = HC:addRectangle(position.x, position.y, size.x, size.y)
    box.parent = parentObject
    return box
end
	