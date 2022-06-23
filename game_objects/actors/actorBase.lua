-- actorBase.lua
local const require('libs.constants')
local baseGenerate = require('game_objects.base')
local function generate(group, options)
	options.role == const.roleActor
	local base = baseGenerate(group, options)
	-- base.manager.setActors(base)

end

return generate