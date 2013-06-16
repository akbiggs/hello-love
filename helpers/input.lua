-- CLASS
Input = class("helpers.Input")

-- STATIC PROPERTIES
Input.static.keyStates = {
	down = {}
}

-- KEY DOWN METHODS
function Input.anyKeyDown(keys)
	return __.any(keys, function(key) return Input.isKeyDown(key) end)
end

function Input.isKeyDown(key)
	-- order is important here, for now. Need to trigger onKeyTapped method
	-- from isKeyTapped so isPreviouslyReleased 
	return Input.isKeyTapped(key) or love.keyboard.isDown(key)
end

-- KEY TAPPED METHODS
function Input.anyKeyTapped(keys)
	return __.any(keys, function(key) return Input.isKeyTapped(key) end)
end

function Input.isKeyTapped(key)
	if (love.keyboard.isDown(key) and Input.isPreviouslyReleased(key)) then
		Input.onKeyTapped(key)
		return true
	end

	return false
end

function Input.onKeyTapped(key)
	Input.keyStates.down[key] = true
end

-- KEY RELEASED METHODS
function Input.anyKeyReleased(keys)
	return __.any(keys, function(key) return Input.isKeyReleased(key) end)
end

function Input.isKeyReleased(key)
	return not love.keyboard.isDown(key)
end

function Input.onKeyReleased(key)
	Input.keyStates.down[key] = false
end

function Input.isPreviouslyReleased(key)
	-- TODO: Keep track of previous key state for multiple
	-- listeners on same key tapped event
	return not Input.keyStates.down[key]
end