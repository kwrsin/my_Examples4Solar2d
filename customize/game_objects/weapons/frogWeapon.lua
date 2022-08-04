-- frogWeapon.lua
local const = require('customize.constants')
local weaponBaseGenerate = require('customize.game_objects.weapons.weaponBase')
local physics = require 'physics'
local weaponName = 'frogWeapon'

local function generate(options, actor)
	local base = weaponBaseGenerate(weaponName, options, actor)
	
	-- function base.setup()
	-- 	local function createParts()
	-- 		local rect = display.newRect(base.root, base.root.x, base.root.y, 8, 16)
	-- 		rect:toBack()
	-- 		rect:setFillColor( 1.0, 0.5, 0.5 )
	-- 		physics.addBody( rect, 'dynamic', {isSensor=true} )
	-- 		rect.collision = function(self, event)
	-- 			if event.phase == 'began' then
	-- 				if event.other._role == const.role_npc then

	-- 				elseif event.other._role == const.role_enemy then
	-- 					DEBUG('hit')
	-- 				elseif event.other._role == const.role_item then

	-- 				elseif event.other._role == const.role_bullet then

	-- 				elseif event.other._role == const.role_player then

	-- 				end
	-- 			end
	-- 		end
	-- 		rect:addEventListener('collision', rect)
	-- 		base.root.gravityScale = 0.0
	-- 		return rect
	-- 	end
	-- 	local partsNum = 8	
	-- 	local nextParts = createParts()
	-- 	for i = 1, partsNum do
	-- 		local newParts = createParts()
	-- 		physics.newJoint( "rope", nextParts, newParts, 0, 0 )
	-- 		nextParts = newParts
	-- 	end
	-- 	base.lastParts = nextParts

	-- end
	base.setup()
	base.offsetPosition(8)
	base.hit = false

	function base.start()
		base.actor.actionRunning = true
		if base.root.anchorX == 1 or base.root.anchorX == 0 then
			transition.scaleTo( base.root, {time=300, xScale=5, onComplete=function() 
				transition.scaleTo(base.root, {time=200, xScale=1, onComplete=function() base.clear() end})
			end} )
		elseif base.root.anchorY == 1 or base.root.anchorY == 0  then
			transition.scaleTo( base.root, {time=300, yScale=5, onComplete=function() 
				transition.scaleTo(base.root, {time=200, yScale=1, onComplete=function() base.clear() end})
			end} )
		end		
	end
	Runtime:addEventListener( 'enterFrame', function(event)
		local function hasCollidedRect( obj1, obj2 )
		    if ( obj1 == nil ) then
		        return false
		    end
		    if ( obj2 == nil ) then
		        return false
		    end		 
		    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
		    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
		    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
		    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
		    return ( left or right ) and ( up or down )
		end
		
		if not base.actor.actionRunning then return end
		if base.hit then return end

		if base.actor.isPlayer then
			local enemies = base.actor.manager.enemies or {}
			for _, enemy in ipairs(enemies) do
				if hasCollidedRect(enemy.root, base.root) then
					DEBUG('enemy hit')
					base.hit = not base.hit
				end				
			end
		else
			local player = base.actor.manager.player
			if player and hasCollidedRect(player.root, base.root) then
				DEBUG('player hit')
				base.hit = not base.hit
			end				
		end
	end )
	base.start()
	return base
end

return generate