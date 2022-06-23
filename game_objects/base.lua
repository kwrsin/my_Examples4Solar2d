-- base.lua
local const = require('libs.constant')
local function generate(group, options)
	local base  = {}
	function base.reset(options)
		if options then
			for key, option in pairs(options) do
				base[key] = option
			end
			base.root.x = options.x
			base.root.y = options.y
			base.manager = options.manager
			base.role = options.role or const.roleActor
		end
	end
	base.reset(options)
	base.root = display.newGroup()
	group.insert(base.root)


	return base
end


return generate