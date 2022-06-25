-- actorBase.lua
local const = require('libs.constants')
local baseGenerate = require('game_objects.base')
local physics = require 'physics'

local function generate(actorName, options)
	local base = baseGenerate(options)
	base.manager.setActors(base)
	local isOptions = require(const.imageDotPath .. actorName .. ".actor")
	local imageSheet = base.imageSheet(const.imagePath .. actorName .. "/actor.png", isOptions.sheetData)
	local sqOptions = require(const.imageDotPath .. actorName .. ".sequence")
	local sprite = display.newSprite( base.root, imageSheet, sqOptions )
	base.sprite = sprite
	physics.addBody(base.root, 'dynamic', {friction=0.6, bounce=0.2, density=3, radius=10})
	base.root.gravityScale = 0.0

	function base.play(name)
		if base.sprite.sequence == name and base.sprite.isPlaying then return end
		base.sprite:setSequence(name)
		base.sprite:play()
	end
	function base:enterFrame(event)
		if base.disabled then
			return
		end
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
	function base.moveByBoundary(deltaX, deltaY)
		local spFulfHeight = base.sprite.height / 2
		local spFulfWidth = base.sprite.width / 2
		if deltaY < 0 then
			if base.root.y + deltaY <= base.manager.boundary.top + spFulfHeight then
				base.root.y = base.manager.boundary.top + spFulfHeight
			else
				base.root.y = base.root.y + deltaY
			end
		elseif deltaY > 0 then
			if base.root.y + deltaY >= base.manager.boundary.bottom - spFulfHeight then
				base.root.y = base.manager.boundary.bottom - spFulfHeight
			else
				base.root.y = base.root.y + deltaY
			end
		end
		if deltaX < 0 then
			if base.root.x + deltaX <= base.manager.boundary.left + spFulfWidth then
				base.root.x = base.manager.boundary.left + spFulfWidth
			else
				base.root.x = base.root.x + deltaX
			end
		elseif deltaX > 0 then
			if base.root.x + deltaX >= base.manager.boundary.right - spFulfWidth then
				base.root.x = base.manager.boundary.right - spFulfWidth
			else
				base.root.x = base.root.x + deltaX
			end
		end
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