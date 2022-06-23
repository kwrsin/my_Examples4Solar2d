-- actorBase.lua
local const = require('libs.constants')
local baseGenerate = require('game_objects.base')
local function generate(group, actorName, options)
	options.role = const.roleActor
	local base = baseGenerate(group, options)
	base.manager.setActors(base)
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
		if base.buttonStatus then
			local cur = base.buttonStatus.cur
			if cur then
				base.onPressedCur(cur)
			end
			local btnA = base.buttonStatus.btnA
			if btnA then
				base.onPressedBtnA(btnA)
			end
			local btnB = base.buttonStatus.btnB
			if btnB then
				base.onPressedBtnB(btnB)
			end
		else
			base.waiting()
		end
	end
	function base.startEnterFrame()
		Runtime:addEventListener( 'enterFrame', base )
	end
	function base.stopEnterFrame()
		Runtime:removeEventListener( 'enterFrame', base )
	end
	function base.move(deltaX, deltaY)
		base.root:translate( deltaX, deltaY )
	end

	-- virtual
	function base.onPressedCur(value)
	end
	function base.onPressedBtnA(value)
	end
	function base.onPressedBtnB(value)
	end
	function base.waiting()
	end
	base.startEnterFrame()
	return base
end

return generate