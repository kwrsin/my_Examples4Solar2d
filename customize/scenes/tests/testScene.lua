-- testScene.lua
local const = require('customize.constants')
local composer = require('composer')
local redHeadGenerate = require('customize.game_objects.actors.redHead')

local scene = composer.newScene()
local physics = require('physics')
local appStatus = require('libs.appStatus')

local player

function scene:create(event)
	local sceneGroup = self.view

	physics.start(false)
	player = redHeadGenerate({group=sceneGroup, x=const.cx, y=const.cy, disabled=false})
end

function scene:show(event)
	if event.phase == 'will' then
		appStatus.controller.show()
		appStatus.manager.setPlayer(player)
		appStatus.manager.setWorldBoundary(const.actualWidth, const.actualHeight)
	elseif event.phase == 'did' then
	end
end

function scene:hide(event)
	if event.phase == 'will' then
	elseif event.phase == 'did' then
	end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene