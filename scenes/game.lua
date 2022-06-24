-- game.lua
require = require
local composer = require('composer')
local scene = composer.newScene( )
local const = require('libs.constants')
local manager = require('managers.manager')

function scene:create(event)
	manager.start()
	local sceneGroup = scene.view
	manager.createLevel(sceneGroup)
end

function scene:show(event)
	system.activate( "multitouch" )
end

function scene:hide(event)
	-- manager.stop()
	system.deactivate( "multitouch" )
end


scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene