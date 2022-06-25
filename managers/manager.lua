-- manager.lua
require = require
local const = require('libs.constants')
local load = require('libs.levelLoader')
local physics = require('physics')

local manager = {
	ui_mode = false,
	actors = {},
	gameObjects = {}
}

function manager.setPlayer(player)
	manager.player = player
end

function manager.setBanner(banner)
	manager.banner = banner
end

function manager.setActors(actor)
	table.insert(manager.actors, actor)
	manager.setGameObject(actor)
end

function manager.playGame()
	for i, actor in ipairs(manager.actors) do
		actor.disabled = false
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

function manager.createLevel(sceneGroup)
	physics.start(false)
	load(sceneGroup, manager)
end

function manager.start()
	physics.start(true)
	-- physics.setDrawMode( "hybrid" ) 
	manager.banner.start(
	function()
		print("GO!")
		manager.playGame()
	end)
end

function manager.stop()
	physics.stop()
end

return manager