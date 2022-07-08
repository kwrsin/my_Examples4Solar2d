-- manager.lua
local const = require('libs.constants')
local load = require('loaders.levelLoader')
local physics = require('physics')
local composer = require('composer')
local scenarioIndice = require('assets.scenarios.scenarioIndice')
local appStatus = require('libs.appStatus')

local pressedCur = false
local pressedBtnA = false
local pressedBtnB = false

local manager = {
	ui_mode = false,
	actors = {},
	gameObjects = {},
	controller = nil,
	enemies ={},
	inGame = false,
}

function manager.setPlayer(player)
	manager.player = player
end

function manager.addEnemy(enemy)
	table.insert(manager.enemies, enemy)
end

function manager.setBanner(banner)
	manager.banner = banner
	manager.setGameObject(banner)
end

function manager.setGameOver(gameover)
	manager.gameover = gameover
	manager.setGameObject(gameover)
end

function manager.setActor(actor)
	table.insert(manager.actors, actor)
	manager.setGameObject(actor)
end

function manager.playGame()
	manager.inGame = true
	for i, actor in ipairs(manager.actors) do
		actor.disabled = false
	end
end

function manager.stopActors()
	manager.inGame = false
	for i, actor in ipairs(manager.actors) do
		actor.disabled = true
	end
end

function manager.setGameObject(gameObject)
	table.insert(manager.gameObjects, gameObject)
end

function manager.setButtonStatus(status)
	if manager.ui_mode then
		manager.player.buttonStatus = nil
		if status and status.cur then
			pressedCur = true
		elseif status and status.btnA then
			pressedBtnA = true
		elseif status and status.btnB then
			pressedBtnB = true
		end
		if pressedCur and (not status or not status.cur) then
			pressedCur = false
			DEBUG("pressedCur")
		elseif pressedBtnA and (not status or not status.btnA) then
			pressedBtnA = false
			appStatus.dialogue.flush()
		elseif pressedBtnB and (not status or not status.btnB) then
			pressedBtnB = false
			DEBUG("pressedBtnB")
		end
	elseif manager.player then
		manager.player.buttonStatus = status
	end
end

function manager.setWorldBoundary(worldWidth, worldHeight)
	manager.boundary = {
	    top = 0,
	    bottom = worldHeight,
	    right = worldWidth,
	    left = 0
	  }
end

function manager.resetAllGameObjects()
	for i, go in ipairs(manager.gameObjects) do
		go.reset()
	end	
end

function manager.createLevel(sceneGroup)
	physics.start(false)
	load(sceneGroup, manager)
end

function manager.setCamera(camera)
	manager.camera = camera
end

local function enterFrame(event)
	appStatus.controller:enterFrame(event)
	for _, actor in ipairs(manager.actors) do
		actor:enterFrame(event)
	end
end

function manager.focusPlayer()
	manager.camera:setFocus(manager.player.root)
end

function manager.startEnterFrame()
	Runtime:addEventListener( 'enterFrame', enterFrame )
end

function manager.stopEnterFrame()
	Runtime:removeEventListener( 'enterFrame', enterFrame )
end
--[[
 GAME SCENARIO
--]]
function manager.start()
	physics.start(true)
	-- physics.setDrawMode( "hybrid" ) 
	manager.resetAllGameObjects()
	manager.startEnterFrame()
	 manager.focusPlayer()

	appStatus.controller.show()
	manager.banner.start(
	function()
		manager.playGame()
	end)
end

function manager.stop()
	manager.stopEnterFrame()
	appStatus.controller.hide()
	manager.stopActors()
	manager.gameover.start(
		function()
			composer.gotoScene("scenes.title")
		end)
end

function manager.runScenario( scenario_index, playNumber )
	if not playNumber or playNumber < 0 then playNumber = 1 end
	manager.ui_mode = true
	local scenario = require(scenarioIndice[scenario_index])
	appStatus.dialogue.show2(scenario.sentences[playNumber])
end

return manager