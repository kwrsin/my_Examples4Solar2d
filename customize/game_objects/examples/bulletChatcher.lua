-- bulletChatcher.lua
local const = require('customize.constants')
local baseGenerate = require('customize.game_objects.base')
local emitterParams = require('customize.game_objects.examples.emitter')

local function generate(options)
	local base = baseGenerate(options)
	physics.addBody(
		base.root, 
		'static', 
		{
			box={
				halfWidth=options.halfWidth, 
				halfHeight=options.halfHeight}, 
			isSensor=true} )
	base.root.collision = function(self,event)
		if event.phase == 'began' then
			local emitter = display.newEmitter( emitterParams )
			emitter.x = event.other
			emitter.y = event.other
			base.root:insert( emitter )

			event.other:removeSelf()
		elseif event.phase == 'ended' then

		end
	end
	base.root:addEventListener( 'collision' )
	return base
end


return generate