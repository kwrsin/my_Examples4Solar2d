-- testScene2.lua
local const = require('customize.constants')
local composer = require('composer')
local physics = require('physics')
physics.start()
-- physics.setDrawMode( 'hybrid' )

local bulletGenerate = require('customize.game_objects.examples.bullet')
local bulletChatcherGenerate = require('customize.game_objects.examples.bulletChatcher')

local scene = composer.newScene( )

function scene:create(event)
	local sceneGroup = self.view
	bulletChatcherGenerate({group=sceneGroup, x=const.cx, y=0, halfWidth=const.cx, halfHeight=15})
end

function scene:show(event)
	local sceneGroup = self.view
	if event.phase == 'will' then

	elseif event.phase == 'did' then
	end
end

function scene:hide(event)
	if event.phase == 'will' then
	elseif event.phase == 'did' then
	end
end

Runtime:addEventListener( 'touch', function(event)
	if event.phase == 'began' then
		bulletGenerate({x=const.cx, y=const.cy, dx=0, dy=-0.1})
	end
end)

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene