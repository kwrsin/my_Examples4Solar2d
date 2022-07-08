-- redHead.lua
local const = require('customize.constants')
local actorGenerate = require('customize.game_objects.actors.actorBase')
local function generate(options)
	local actorBase = actorGenerate('red_head', options)

	function actorBase.up()
		actorBase.moveByBoundary( 0, -2 )
		actorBase.play('up')
	end
	function actorBase.down()
		actorBase.moveByBoundary( 0, 2 )
		actorBase.play('down')
	end
	function actorBase.right()
		actorBase.moveByBoundary( 2, 0 )
		actorBase.play('right')
	end
	function actorBase.left()
		actorBase.moveByBoundary( -2, 0 )
		actorBase.play('win')
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
	function actorBase.setup()
		actorBase.buttonStatus = nil
		actorBase.play('lose')
	end

	return actorBase
end

return generate
