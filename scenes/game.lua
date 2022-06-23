-- game.lua
require = require
local composer = require('composer')
local scene = composer.newScene( )
local const = require('libs.constants')
local load = require('libs.levelLoader')

local function create(sceneGroup)
	local label = display.newText(sceneGroup, "ゲーム中", const.cx, const.cy, native.systemFont, 34)
	label:setFillColor( 255 / 255, 0.5, 0.3 )
end

function scene:create(event)
	local sceneGroup = scene.view
	create(sceneGroup)
	load(sceneGroup)
end

function scene:show(event)
end

function scene:hide(event)
end


scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene