-- frogWeapon.lua
local const = require('customize.constants')
local sounds = require('libs.sounds')
local baseGenerate = require('customize.game_objects.base')
local physics = require 'physics'

local function generate(weaponName, options, actor)
	options.role = const.role_bullet
	local base = baseGenerate(options)
	function base.setup()
		local isOptions = require(const.imageDotPath .. "weapons." .. weaponName .. ".actor")
		local imageSheet = base.imageSheet(const.imagePath .. "weapons/"  .. weaponName .. "/actor.png", isOptions.sheetData)
		local sequenceName = weaponName .. ".sequence"
		if options.sequenceName then
			sequenceName = options.sequenceName
		else
		end
		local sqOptions = require(const.imageDotPath .. "weapons."  .. sequenceName)
		local sprite = display.newSprite( base.root, imageSheet, sqOptions )
		base.sprite = sprite
		physics.addBody(base.root, 'dynamic', {isSensor=true})
		base.root.collision = function(self, event)
			if event.phase == 'began' then
				if event.other._role == const.role_npc then
				elseif event.other._role == const.role_enemy then
				elseif event.other._role == const.role_item then
				elseif event.other._role == const.role_bullet then
				elseif event.other._role == const.role_player then
				end
			end
		end
		base.root:addEventListener('collision', base.root)
		base.root.gravityScale = 0.0
	end
	base.actor = actor

	function base.offsetPosition(offset)
		base.root.anchorChildren = true
		local dir = actor.direction()
		if dir == const.dir_up then
			base.root.y = base.root.y - offset
			base.root.anchorY = 1
			base.root.anchorX = 0.5
			base.sprite:setSequence( const.dir_up )
		elseif dir == const.dir_down then
			base.root.y = base.root.y + offset
			base.root.anchorY = 0
			base.root.anchorX = 0.5
			base.sprite:setSequence( const.dir_down )
		elseif dir == const.dir_left then
			base.root.x = base.root.x - offset
			base.root.anchorY = 0.5
			base.root.anchorX = 1
			base.sprite:setSequence( const.dir_left )
		elseif dir == const.dir_right then
			base.root.x = base.root.x + offset
			base.root.anchorY = 0.5
			base.root.anchorX = 0
			base.sprite:setSequence( const.dir_right )
		else
			base.root.y = base.root.y + offset
			base.root.anchorY = 0
			base.root.anchorX = 0.5
			base.sprite:setSequence( const.dir_down )
		end
	end

	function base.clear()
		base.actor.actionRunning = false
		base.root:removeSelf( )
		base.root = nil
	end

	function base.hasCollidedRect( obj1, obj2 )
		if not obj2 then obj2 = base.root end
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
	
	-- function base.start()
	-- 	base.actor.actionRunning = true
	-- 	local timerid = timer.performWithDelay(2000, function()
	-- 		base.clear()
	-- 	end)
	-- end
	-- base.start()
	return base
end

return generate