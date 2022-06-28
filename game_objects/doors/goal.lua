-- goal.lua
local const = require('libs.constants')
local baseGenerate = require('game_objects.base')
local physics = require('physics')

local function generate(tileset, localId, options)
	local base = baseGenerate(options)
	base.manager.setGameObject(base)
	local image = display.newImage(base.root, tileset, localId)
	physics.addBody(base.root, 'static', {isSensor=true})
	base.root.collision = function(self, event)
		if event.phase == 'began' then
			base.manager.stop()
		end
	end
	base.root:addEventListener("collision", base.root)
	return base
end

return generate
