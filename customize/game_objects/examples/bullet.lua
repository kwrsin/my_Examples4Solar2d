-- bullet.lua

local const = require('customize.constants')
local baseGenerate = require('customize.game_objects.base')

function generator(options)
	local base = baseGenerate(options)
	local rect = display.newRect( base.root, 0, 0, 4, 10 )
	rect:setFillColor( 1.0, 0, 0, 1 )
	physics.addBody( base.root, 'dynamic', {isSensor=true} )
	base.root.gravityScale = 0.0
	base.root:applyLinearImpulse( options.dx, options.dy, base.root.x, base.root.y )
	base.root.myName = 'bullet'
	return base
end


return generator