require "lib.middleclass"
__ = require "lib.underscore"
inspect = require "lib.inspect"

Input = class("helpers.Input")
Input.static.keyStates = {
	down = {}
}

function Input:anyKeyDown(keys)
	return __.any(keys, function(key) return Input:isKeyDown(key) end)
end

function Input:isKeyDown(key)
	if love.keyboard.isDown(key) then
		if Input:previouslyReleased(key) then
			Input:onKeyTapped(key)
		end
		return true
	end

	return false
end

function Input:anyKeyTapped(keys)
	return __.any(keys, function(key) return Input:isKeyTapped(key) end)
end

function Input:isKeyTapped(key)
	if (love.keyboard.isDown(key) and Input:previouslyReleased(key)) then
		Input:onKeyTapped(key)
		return true
	end

	return false
end

function Input:onKeyTapped(key)
	Input.keyStates.down[key] = true
end

function Input:onKeyReleased(key)
	Input.keyStates.down[key] = false
end

function Input:previouslyReleased(key)
	return not Input.keyStates.down[key]
end