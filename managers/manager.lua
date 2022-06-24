-- manager.lua
require = require
local const = require('libs.constants')
local load = require('libs.levelLoader')

local manager = {
	ui_mode = false,
	actors = {}
}

function manager.setPlayer(player)
	manager.player = player
end

function manager.setActors(actor)
	table.insert(manager.actors, actor)
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
	load(sceneGroup, manager)
end

return manager