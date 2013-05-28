__ = require "lib.underscore"
inspect = require "lib.inspect"

function anyKeyDown(keys)
	return __.any(keys, function(key) return love.keyboard.isDown(key) end)
end