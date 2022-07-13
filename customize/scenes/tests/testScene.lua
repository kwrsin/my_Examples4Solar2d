-- testScene.lua
local const = require('customize.constants')
local composer = require('composer')
local rectRedGenerate = require('customize.game_objects.actors.rectRed')

local scene = composer.newScene()
local physics = require('physics')
local appStatus = require('customize.appStatus')

local function createCloud(group)
	local cloud = display.newImage(group, 'assets/images/others/cloud.png', const.cx + 80, 80)

end

local function createMountain(group)
	display.newImage(group, 'assets/images/others/mountain.png', const.cx, 120)
end

local function createRedHouse(group)
	display.newImage(group, 'assets/images/others/redHouse.png', 100, 206)
end

local function createBuil0(group, x, y)
	local build0 = display.newImage(group, 'assets/images/others/buil0.png', x, y)
	physics.addBody( build0, 'static' )
end	

local function createBuil1(group, x, y)
	local build0 = display.newImage(group, 'assets/images/others/buil1.png', x, y)
end	

local function createBackground(group)
	createMountain(group)
	createRedHouse(group)
	createBuil0(group, 60, 290)
	createBuil0(group, 80, 290)
	createBuil0(group, 180, 390)
	createCloud(group)
end

local movingBlock
local function createMovingBlock(group, x, y, xRange, yRange)
	local xOrigin = x
	local yOrigin = y
	local xRange = xRange
	local yRange = yRange
	local xReverse = 1
	local yReverse = 1
	local position = {}
	local onBlock = nil
	movingBlock = display.newRect( group, x, y, 32, 32 )
	Runtime:addEventListener( 'enterFrame', function(event)
		if xReverse > 0 and movingBlock.x > xOrigin + xRange then
			movingBlock.x = xOrigin + xRange
			xReverse = xReverse * -1
		elseif xReverse < 0 and movingBlock.x < xOrigin then
			movingBlock.x = xOrigin
			xReverse = xReverse * -1
		elseif xRange > 0 then
			position.x = 2 * xReverse
		else
			position.y = 0
		end
		if yReverse > 0 and movingBlock.y > yOrigin + yRange then
			movingBlock.y = yOrigin + yRange
			yReverse = yReverse * -1
		elseif yReverse < 0 and movingBlock.y < yOrigin then
			movingBlock.y = yOrigin
			yReverse = yReverse * -1
		elseif yRange > 0 then
			position.y = 2 * yReverse
		else
			position.y = 0
		end
		if onBlock then
			onBlock:translate(position.x, position.y)
		end
		movingBlock:translate(position.x, position.y)
	end )
	physics.addBody(movingBlock, 'static', {isSensor=true})
	movingBlock.collision = function(self, event)
		if event.phase == 'began' then
			onBlock = event.other
		elseif event.phase == 'ended' then
			onBlock = nil
		end
	end
	movingBlock:addEventListener('collision')
end

local player

function scene:create(event)
	local sceneGroup = self.view

	physics.start(false)

	createBackground(sceneGroup)
	createMovingBlock(sceneGroup, 40, 320, 100, 0)
	player = rectRedGenerate({group=sceneGroup, x=const.cx, y=const.cy, disabled=false})
	player.root.myName = 'player'

	createBuil1(sceneGroup, 60, 290 - 16)
	createBuil1(sceneGroup, 80, 290 - 16)
	createBuil1(sceneGroup, 180, 390 - 16)
end

function scene:show(event)
	if event.phase == 'will' then
		appStatus.manager.startEnterFrame()
		appStatus.controller.show()
		appStatus.manager.setPlayer(player)
		appStatus.manager.setWorldBoundary(const.actualWidth, const.actualHeight)
	elseif event.phase == 'did' then
	end
end

function scene:hide(event)
	if event.phase == 'will' then
		appStatus.manager.stopEnterFrame()
	elseif event.phase == 'did' then
	end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene