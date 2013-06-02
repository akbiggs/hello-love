Collider = require "lib.hardon"
 
-- HARDON CALLBACKS
function onCollide(dt, shape_a, shape_b, dx, dy)
    ax, ay = shape_a:center()

    handleCollision(shape_a.parent, shape_b.parent, dx, dy)
    handleCollision(shape_b.parent, shape_a.parent, -dx, -dy)
end

function handleCollision(obj, other, dx, dy)
	if obj.canCollide then
		obj:collide(other, dx, dy)
	end
end

-- STATIC
HC = Collider(10, onCollide)