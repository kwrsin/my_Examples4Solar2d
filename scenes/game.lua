-- game.lua
require = require
local composer = require('composer')
local scene = composer.newScene( )
local const = require('libs.constants')
local manager = require('managers.manager')

function scene:create(event)
	local sceneGroup = scene.view
	manager.createLevel(sceneGroup)
end

function scene:show(event)
	local sceneGroup = scene.view
	if event.phase == "will" then
		system.activate( "multitouch" )
		manager.start()
	elseif event.phase == "did" then
	end
end

function scene:hide(event)
	local sceneGroup = scene.view
	if event.phase == "will" then
	elseif event.phase == "did" then
		system.deactivate( "multitouch" )
	end
end


scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene