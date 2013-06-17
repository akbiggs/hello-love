-- Returns a value between a and b linearly derived from t.
function math.lerp(a, b, t)
	return a + t * (b - a)
end

-- Averages an arbitrary number of angles.
function math.averageAngles(...)
    local x,y = 0,0
    for i=1,select('#',...) do local a= select(i,...) x, y = x+math.cos(a), y+math.sin(a) end
    return math.atan2(y, x)
end

-- Returns the distance between two points.
function math.distance(pos1, pos2) return ((pos2.x-pos1.x)^2+(pos2.y-pos1.y)^2)^0.5 end

-- Returns the angle between two points.
function math.getAngle(pos1, pos2) return math.atan2(pos2.x-pos1.x, pos2.y-pos1.y) end

function math.angleToDirection(angle)
	return vector(math.sin(angle), math.cos(angle))
end

-- Returns the closest multiple of 'size' (defaulting to 10).
function math.multiple(n, size) size = size or 10 return math.round(n/size)*size end

-- Clamps a number to within a certain range.
function math.clamp(n, low, high) return math.min(math.max(n, low), high) end

-- Normalizes a position.
function math.normalize(pos)
	local l = (pos.x * pos.x + pos.y * pos.y)^.5
	if l == 0 then
		return vector(0, 0)
	else
		return vector(pos.x/l, pos.y/l)
	end 
end

-- Returns 'n' rounded to the nearest 'd'th.
function math.round(n, d) d = 10^(d or 0) return math.floor(n*d+.5)/d end

-- Randomly returns either -1 or 1.
function math.rsign() return math.random(2) == 2 and 1 or -1 end

-- Returns 1 if number is positive, -1 if it's negative, or 0 if it's 0.
function math.sign(n) return n>0 and 1 or n<0 and -1 or 0 end

-- Checks if two line segments intersect. Line segments are given in form of ({x,y},{x,y}, {x,y},{x,y}).
function checkIntersect(l1p1, l1p2, l2p1, l2p2)
    local function checkDir(pt1, pt2, pt3) return math.sign(((pt2.x-pt1.x)*(pt3.y-pt1.y)) - ((pt3.x-pt1.x)*(pt2.y-pt1.y))) end
    return (checkDir(l1p1,l1p2,l2p1) ~= checkDir(l1p1,l1p2,l2p2)) and (checkDir(l2p1,l2p2,l1p1) ~= checkDir(l2p1,l2p2,l1p2))
end