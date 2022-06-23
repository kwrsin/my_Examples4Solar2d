-- title.lua
require = require
local composer = require('composer')

local const = require('libs.constants')

local scene = composer.newScene( )

local function createTitle(group)
	local function createStartButton(group)
		local buttonGroup = display.newGroup()
		buttonGroup.x =  const.cx
		buttonGroup.y = const.cy + 160
		local button = display.newRoundedRect( buttonGroup, 0, 0, 120, 60, 30 )
		button:setFillColor( 12/ 255, 128 / 255, 128 / 255 )

		local label = display.newText(buttonGroup, 'スタート', 0, 0, system.nativeFont, 24)
		group:insert(buttonGroup)
		group:addEventListener( 'touch', function(event)
			composer.gotoScene( 'scenes.game' )
		end )
	end

	local background = display.newRect(const.cx, const.cy, const.actualWidth, const.actualHeight)
	background:setFillColor( 128 / 255, 10 / 255, 40 / 255 )
	group:insert(background)
	local title = display.newText( 'ハローワールド', const.cx, const.cy, system.nativeFont, 32)
	group:insert(title)
	createStartButton(group)
end

function scene:create(event)
	local sceneGroup = scene.view
	createTitle(sceneGroup)
end

function scene:show(event)
	if event.phase == 'will' then
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