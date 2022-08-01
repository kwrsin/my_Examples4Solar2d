-- frogWeapon.lua
local const = require('customize.constants')
local weaponBaseGenerate = require('customize.game_objects.weapons.weaponBase')
local physics = require 'physics'
local weaponName = 'frogWeapon'

local function generate(options, actor)
	local base = weaponBaseGenerate(weaponName, options, actor)
	base.root.anchorChildren = true
	local dir = actor.direction()
	if dir == const.dir_up then
		base.root.y = base.root.y - 8
		base.root.anchorY = 1
		base.root.anchorX = 0.5
		base.sprite:setSequence( const.dir_up )
	elseif dir == const.dir_down then
		base.root.y = base.root.y + 8
		base.root.anchorY = 0
		base.root.anchorX = 0.5
		base.sprite:setSequence( const.dir_down )
	elseif dir == const.dir_left then
		base.root.x = base.root.x - 8
		base.root.anchorY = 0.5
		base.root.anchorX = 1
		base.sprite:setSequence( const.dir_left )
	elseif dir == const.dir_right then
		base.root.x = base.root.x + 8
		base.root.anchorY = 0.5
		base.root.anchorX = 0
		base.sprite:setSequence( const.dir_right )
	else
		base.root.y = base.root.y + 8
		base.root.anchorY = 0
		base.root.anchorX = 0.5
		base.sprite:setSequence( const.dir_down )
	end

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
	base.start()
	return base
end

return generate