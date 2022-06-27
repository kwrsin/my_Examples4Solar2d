-- base.lua
local const = require('libs.constants')

local function generate(options)
	local base  = {}
	function base.reset(options)
		if options then
			for key, option in pairs(options) do
				base[key] = option
			end
			base.root.x = options.x
			base.root.y = options.y
			base.manager = options.manager
			base.isPlayer = options.isPlayer or false
			base.disabled = options.disabled or false
		end
	end
	function base.imageSheet(actorPath, options)
		return graphics.newImageSheet( actorPath, options)
	end
	base.root = display.newGroup()
	base.reset(options)
	return base
end


return generate