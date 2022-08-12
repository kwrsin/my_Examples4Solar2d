-- crowWeapon.lua
local const = require('customize.constants')
local weaponBaseGenerate = require('customize.game_objects.weapons.weaponBase')
local weaponName = 'crowWeapon'

local function generate(options, actor)
	local base = weaponBaseGenerate(weaponName, options, actor)

	base.setup()
	function base.start()
		if not base.actor then return end
		base.play('attack')
		base.actor.bodyAttack()
	end
	function base.spriteListener(event)
		if event.phase == 'ended' then
			base.clear()
			actor.skills.push(weaponName)					
		end
	end

	base.start()
	return base
end

return generate