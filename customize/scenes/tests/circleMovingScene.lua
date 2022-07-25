-- circleMovingScene.lua
local const = require('customize.constants')
local composer = require('composer')

local scene = composer.newScene( )
local player
local rect
local rect2

local function createPlayer(sceneGroup, x, y)
	player = display.newGroup()
	sceneGroup:insert(player)
	player.x, player.y = x, y
	rect = display.newRect( player, 0, 0, 16, 16 )
	rect:setFillColor( 1, 0, 0, 1 )
	rect.x = 60

	rect2 = display.newRect( player, 0, 0, 16, 16 )
	rect2:setFillColor( 0, 0, 1, 1 )
	rect2.x = -60
end

local function animPlayer()
	rect.rotation = rect.rotation - 15
	rect2.rotation = rect2.rotation - 15
	player.rotation = player.rotation + 5
end

Runtime:addEventListener( 'enterFrame', function(event)
	animPlayer()
end )

function scene:create(event)
	local sceneGroup = self.view
	createPlayer(sceneGroup, const.cx, const.cy)
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

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )


return scene