-- frog.lua
local const = require('customize.constants')
local actorGenerate = require('customize.game_objects.actors.actorBase')
local function generate(options)
	local actorBase = actorGenerate('frog', options)

	function actorBase.up()
		actorBase.stepByBoundary( 0, -64 )
		actorBase.play('up')
	end
	function actorBase.down()
		actorBase.stepByBoundary( 0, 64 )
		actorBase.play('down')
	end
	function actorBase.right()
		actorBase.stepByBoundary( 64, 0 )
		actorBase.play('right')
	end
	function actorBase.left()
		actorBase.stepByBoundary( -64, 0 )
		actorBase.play('left')
	end
	function actorBase.stepByBoundary(deltaX, deltaY)
		if actorBase.actionRunning == true then return end
		-- sounds.playSE(const.walking)
		local spHalfHeight = actorBase.sprite.height / 2
		local spHalfWidth = actorBase.sprite.width / 2
		actorBase.actionRunning = true
		local x, y
		if deltaY < 0 then
			if actorBase.root.y + deltaY <= actorBase.manager.boundary.top + spHalfHeight then
				y = actorBase.manager.boundary.top + spHalfHeight
			else
				y = actorBase.root.y + deltaY
			end
		elseif deltaY > 0 then
			if actorBase.root.y + deltaY >= actorBase.manager.boundary.bottom - spHalfHeight then
				y = actorBase.manager.boundary.bottom - spHalfHeight
			else
				y = actorBase.root.y + deltaY
			end
		end
		if deltaX < 0 then
			if actorBase.root.x + deltaX <= actorBase.manager.boundary.left + spHalfWidth then
				x = actorBase.manager.boundary.left + spHalfWidth
			else
				x = actorBase.root.x + deltaX
			end
		elseif deltaX > 0 then
			if actorBase.root.x + deltaX >= actorBase.manager.boundary.right - spHalfWidth then
				x = actorBase.manager.boundary.right - spHalfWidth
			else
				x = actorBase.root.x + deltaX
			end
		end
		transition.moveTo( actorBase.root, {time=500, x=x, y=y, onComplete=function(event)
			actorBase.actionRunning = false
		end} )
	end
	-- override
	function actorBase.onPressedCur(value)
		if value.x * value.x > value.y * value.y then
			if value.x > 0 then
				actorBase.right()
			elseif value.x < 0 then
				actorBase.left()
			end
		elseif value.x * value.x < value.y * value.y then
			if value.y > 0 then
				actorBase.down()
			elseif value.y < 0 then
				actorBase.up()
			end
		end
	end
	function actorBase.spriteListener(event)
			if string.starts( event.target.sequence, "attack" ) then
				if event.phase == 'ended' then
						actorBase.skills.fire()
				end
			end
	end
	function actorBase.onPressedBtnA(value)
		if value == nil then return end
		if actorBase.actionRunning == true then return end
		local dir = actorBase.direction()
		if not dir then dir = const.dir_down end
		local attackName = 'attack_' .. dir
		actorBase.play(attackName)
	end
	function actorBase.onPressedBtnB(value)
		if actorBase.actionRunning == true then return end
	end
	function actorBase.waiting()
		if actorBase.actionRunning == true then return end
		actorBase.play('wait')
	end	
	function actorBase.setup()
		actorBase.buttonStatus = nil
		actorBase.play('wait')
		actorBase.actionRunning = false
	end

	return actorBase
end

return generate
