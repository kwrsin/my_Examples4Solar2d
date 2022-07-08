-- base.lua
local const = require('customize.constants')
local appStatus = require('libs.appStatus')

local function generate(options)
	local base  = {}
	function base.reset()
		if base.options then
			for key, option in pairs(base.options) do
				base[key] = option
			end
			base.root.x = base.options.x
			base.root.y = base.options.y
			base.isPlayer = base.options.isPlayer or false
			base.disabled = base.options.disabled or false
			base.group = base.options.group
			if base.isPlayer then
				base.root._role = const.role_player
			else
				base.root._role = base.options.role or const.role_npc	
			end
			base.root._scenario_index = base.options.scenario_index
		end
		base.setup()
	end
	function base.setup()
	end
	function base.imageSheet(actorPath, options)
		return graphics.newImageSheet( actorPath, options)
	end
	base.options = options or {}
	base.root = display.newGroup()
	base.reset()
	if base.group then
		base.group:insert(base.root)
	end
	base.manager = appStatus.manager
	return base
end


return generate