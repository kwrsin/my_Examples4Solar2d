-- crow.lua
local const = require('customize.constants')
local actorGenerate = require('customize.game_objects.actors.actorBase')
local function  generate( options )
	local actorBase = actorGenerate('crow', options)
	function actorBase.waiting()
		-- if actorBase.actionRunning == true then return end
		-- actorBase.play('wait')
	end	
	function actorBase.setup()
		actorBase.buttonStatus = nil
		actorBase.play('wait')
		actorBase.actionRunning = false
	end
	function actorBase.bodyAttack()
		local diamiter = 280
		local function collided(target)
			local scope = {x=actorBase.root.x, y=actorBase.root.y, contentWidth=diamiter}
			return actorBase.hasCollidedCircle( scope, target.root )
		end
		local target = actorBase.getTarget()
		if not target then return end
		if not collided(target) then return end
		actorBase.actionRunning = true
		actorBase.play('attack')
		local distanceX = target.root.x - actorBase.root.x
		local distanceY = target.root.y - actorBase.root.y
		actorBase.root.rotation = math.deg( math.atan2( distanceX, distanceY ) )
		transition.moveTo( actorBase.root, {time=300, x=target.root.x, y=target.root.y, onComplete=function()
			actorBase.root.rotation = 0
			actorBase.play('wait')
			actorBase.actionRunning = false
		end} )
	end
	function actorBase.think()
		if actorBase.actionRunning == true then return end
		local actionId = math.floor(math.random(1, 10))
		if actionId == 1 then
			actorBase.play('up')
		elseif actionId == 2 then
			actorBase.play('down')
		elseif actionId == 3 then
			actorBase.play('left')
		elseif actionId == 4 then
			actorBase.play('right')
		elseif actionId >= 5 then
			actorBase.skills.fire()
		end
		local timerid = timer.performWithDelay(1000, function()
			actorBase.thinking = false
		end)
	end
	function actorBase.onPressedBtnA(value)
		if value == nil then return end
		if actorBase.actionRunning == true then return end
		actorBase.skills.fire()
	end

	return actorBase
end

return generate