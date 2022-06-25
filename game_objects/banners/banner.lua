-- ready.lua
local const = require('libs.constants')
local baseGenerate = require('game_objects.base')


local function generate(options)
	local base = baseGenerate(options)
	base.manager.setGameObject(base)
	local ready = display.newImage(base.root, options.ready)
	local go = display.newImage(base.root, options.go)
	function base.rewind()
		ready.yScale = 0.1
		go.yScale = 0.1
		ready.alpha = 0
		go.alpha = 0
	end
	base.rewind()

	function base.play(banner, callback)
		transition.scaleTo( banner, {iterations=1, transition=easing.outElastic, yScale=1.0, alpha=1, time=500, onComplete=function()
				transition.scaleTo(banner, {iterations=1, transition=easing.outElastic, yScale=0.1, alpha=0, time=500, onComplete=function()
						if callback then
							callback()
						end
					end })
			end })
	end
	function base.start(callback)
		base.rewind()
		base.play(ready, 
			function() 
				base.play(go, 
					function() 
						if callback then
							callback()
						end
					end) 
			end)
	end
	return base
end

return generate