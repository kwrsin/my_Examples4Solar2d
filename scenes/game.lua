-- game.lua
require = require
local composer = require('composer')
local scene = composer.newScene( )
local const = require('libs.constants')
local manager = require('managers.manager')
local showOnce = false

function scene:create(event)
	local sceneGroup = scene.view
	local controller = event.params.controller
	manager.createLevel(sceneGroup, controller)
end

function scene:show(event)
	system.activate( "multitouch" )
	if showOnce == false then
		manager.start()
		showOnce = true
	end
end

function scene:hide(event)
	-- manager.stop()
	system.deactivate( "multitouch" )
end


scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene