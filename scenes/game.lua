-- game.lua
require = require
local composer = require('composer')
local scene = composer.newScene( )
local const = require('libs.constants')
local load = require('libs.levelLoader')
local redHeadGenerate = require('game_objects.actors.redHead')
local controllerGenerate = require('components.controllerBase')
local manager = require('managers.manager')

local function create(sceneGroup)
	local label = display.newText(sceneGroup, "ゲーム中", const.cx, const.cy, native.systemFont, 34)
	label:setFillColor( 255 / 255, 0.5, 0.3 )
end

function scene:create(event)
	local sceneGroup = scene.view
	create(sceneGroup)
	load(sceneGroup)
	local player = redHeadGenerate(scene.view, {x=const.cx, y=const.cy, manager=manager})
	manager.setPlayer(player)
	local controller = controllerGenerate(sceneGroup, manager)
end

function scene:show(event)
	system.activate( "multitouch" )
end

function scene:hide(event)
	system.deactivate( "multitouch" )
end


scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene