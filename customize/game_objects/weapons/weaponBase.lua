-- frogWeapon.lua
local const = require('customize.constants')
local sounds = require('libs.sounds')
local baseGenerate = require('customize.game_objects.base')
local physics = require 'physics'

local function generate(weaponName, options, actor)
	options.role = const.role_bullet
	local base = baseGenerate(options)
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
	physics.addBody(base.root, 'dynamic', {isSensor=true, friction=0.6, bounce=0.2, density=3, radius=10})
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
	base.root.gravityScale = 0.0
	base.actor = actor

	function base.clear()
		base.actor.actionRunning = false
		base.root:removeSelf( )
		base.root = nil
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