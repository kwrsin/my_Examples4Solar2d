-- frogWeapon.lua
local const = require('customize.constants')
local weaponBaseGenerate = require('customize.game_objects.weapons.weaponBase')
local physics = require 'physics'
local weaponName = 'frogWeapon'

local function generate(options, actor)
	local base = weaponBaseGenerate(weaponName, options, actor)
	
	base.setup()
	base.offsetPosition(8)
	base.hit = false

	function base.start()
		base.actor.actionRunning = true
		if base.root.anchorX == 1 or base.root.anchorX == 0 then
			transition.scaleTo( base.root, {time=300, xScale=5, onComplete=function() 
				transition.scaleTo(base.root, {time=200, xScale=1, onComplete=function() base.clear();actor.skills.push(weaponName) end})
			end} )
		elseif base.root.anchorY == 1 or base.root.anchorY == 0  then
			transition.scaleTo( base.root, {time=300, yScale=5, onComplete=function() 
				transition.scaleTo(base.root, {time=200, yScale=1, onComplete=function() base.clear();actor.skills.push(weaponName) end})
			end} )
		end		
	end
	Runtime:addEventListener( 'enterFrame', function(event)		
		if not base.actor.actionRunning then return end
		if base.hit then return end

		if base.actor.isPlayer then
			local enemies = base.actor.manager.enemies or {}
			for _, enemy in ipairs(enemies) do
				if base.hasCollidedRect(enemy.root) then
					DEBUG('enemy hit')
					base.hit = not base.hit
				end				
			end
		else
			local player = base.actor.manager.player
			if player and base.hasCollidedRect(player.root) then
				DEBUG('player hit')
				base.hit = not base.hit
			end				
		end
	end )
	base.start()
	return base
end

return generate