-- reibaishi.lua
local const require('libs.constants')
local actorGenerate = require('game_objects.actors.actorBase')
local function generate(options)
	local actorBase = actorGenerate('reibaishi', options)

	function actorBase.up()
		actorBase.moveByBoundary( 0, -4 )
		actorBase.play('up')
	end
	function actorBase.down()
		actorBase.moveByBoundary( 0, 4 )
		actorBase.play('down')
	end
	function actorBase.right()
		actorBase.moveByBoundary( 4, 0 )
		actorBase.play('right')
	end
	function actorBase.left()
		actorBase.moveByBoundary( -4, 0 )
		actorBase.play('left')
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