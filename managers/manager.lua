-- manager.lua
local const = require('libs.constants')
local load = require('libs.levelLoader')
local physics = require('physics')
local composer = require('composer')

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

--[[
 GAME SCENARIO
--]]
function manager.start()
	physics.start(true)
	-- physics.setDrawMode( "hybrid" ) 
	manager.resetAllGameObjects()
	manager.controller.show()
	manager.banner.start(
	function()
		manager.playGame()
	end)
end

function manager.stop()
	manager.controller.hide()
	manager.stopActors()
	manager.gameover.start(
		function()
			composer.gotoScene("scenes.title")
		end)
end

return manager