-- actorBase.lua
local const = require('libs.constants')
local baseGenerate = require('game_objects.base')
local function generate(group, actorName, options)
	options.role = const.roleActor
	local base = baseGenerate(group, options)
	-- base.manager.setActors(base)
	local isOptions = require(const.imageDotPath .. actorName .. ".actor")
	local imageSheet = base.imageSheet(const.imagePath .. actorName .. "/actor.png", isOptions.sheetData)
	local sqOptions = require(const.imageDotPath .. actorName .. ".sequence")
	local sprite = display.newSprite( base.root, imageSheet, sqOptions )
	base.sprite = sprite

	function base.play(name)
		if base.sprite.sequence == name and base.sprite.isPlaying then return end
		base.sprite:setSequence(name)
		base.sprite:play()
	end
	function base:enterFrame(event)
		-- dead, not ready, 

		-- move, attack
	end
	function base.startEnterFrame()
		Runtime:addEventListener( 'enterFrame', base )
	end
	function base.stopEnterFrame()
		Runtime:removeEventListener( 'enterFrame', base )
	end
	base.startEnterFrame()
	return base
end

return generate