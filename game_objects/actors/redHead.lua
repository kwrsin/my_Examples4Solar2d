-- redHead.lua
local const require('libs.constants')
local actorGenerate = require('game_objects.actors.actorBase')
local function generate(group, options)
	local actorBase = actorGenerate(group, 'red_head', options)

	-- override
	function actorBase.onPressedCur(value)
		if value.x * value.x > value.y * value.y then
			if value.x > 0 then
				actorBase.move( 2, 0 )
				actorBase.play('right')
			elseif value.x < 0 then
				actorBase.move( -2, 0 )
				actorBase.play('win')
			end
		elseif value.x * value.x < value.y * value.y then
			if value.y > 0 then
				actorBase.move( 0, 2 )
				actorBase.play('down')
			elseif value.y < 0 then
				actorBase.move( 0, -2 )
				actorBase.play('up')
			end
		end
	end
	function actorBase.onPressedBtnA(value)
	end
	function actorBase.onPressedBtnB(value)
	end
	function actorBase.waiting()
		actorBase.play('lose')
	end	

	actorBase.play('lose')
	return actorBase
end

return generate
