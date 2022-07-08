-- gameover.lua
local const = require('customize.constants')
local baseGenerate = require('customize.game_objects.base')

local function generate( options )
	local base = baseGenerate(options)
	base.manager.setGameObject(base)
	local gameover = display.newImage(base.root, "assets/images/banners/gameover.png")
	function base.rewind()
		base.root.x = options.x
		base.root.y = options.y
	end
	base.rewind()

	function base.start(callback)
		base.rewind()
		transition.moveTo(base.root, {time=1200, iterations=1, y=const.cy, transition=easing.outBounce, onComplete=function(event)
			base.rewind()
			if callback then
				callback()
			end
		end})
	end

	return base
end
return generate