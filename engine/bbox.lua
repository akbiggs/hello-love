BBox = function(parentObject, position, size)
    box = HC:addRectangle(position.x, position.y, size.x, size.y)
    box.parent = parentObject
    return box
end

function BCircle(parentObject, position, radius)
	circle = HC:addCircle(position.x, position.y, radius)
	circle.parent = parentObject
	return circle
end
