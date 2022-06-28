-- base.lua
local const = require('libs.constants')

local function generate(options)
	local base  = {}
	function base.reset()
		if base.options then
			for key, option in pairs(base.options) do
				base[key] = option
			end
			base.root.x = base.options.x
			base.root.y = base.options.y
			base.manager = base.options.manager
			base.isPlayer = base.options.isPlayer or false
			base.disabled = base.options.disabled or false
			base.group = base.options.group			
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
	base.setup()
	return base
end


return generate