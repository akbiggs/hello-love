Direction = {
	LEFT = -1,
	RIGHT = 1,

	reverse = function(direction) return -direction end;
	random = function() return math.rsign() end
}