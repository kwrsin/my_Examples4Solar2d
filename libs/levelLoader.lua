
require = require
local const = require('libs.constants')
local storage = require('libs.appStorage')
local perspective = require("components.perspective")
local controllerGenerate = require('components.controllerBase')


local redHeadGenerate = require('game_objects.actors.redHead')

local function imageSheet(tileset)
	return graphics.newImageSheet( const.tilesetPath .. tileset.image, {
			width = tileset.tilewidth,
			height = tileset.tileheight,
			numFrames = tileset.tilecount,
			sheetContentWidth = tileset.imagewidth,
			sheetContentHeight = tileset.imageHeight,
		} )
end

local function loadTiles(tilesets)
	local tilesetList = {}
	for i, tileset in ipairs(tilesets) do
		local firstgid = tileset.firstgid
		local is = imageSheet(tileset)
		for i = 1, tileset.tilecount do
			tilesetList[firstgid + i -1] = is
		end
	end
	return tilesetList
end

local function createTile(group, tilesets, gid, x, y)
	display.newImage( 
		group, 
		tilesets[gid], 
		gid,
		x,
		y)
end

local function load(sceneGroup, manager)
	local camera = perspective.createView()
	sceneGroup:insert(camera)
	
	local level_path = storage.level_path
	local level = require(level_path)
	local tilesets = loadTiles(level.tilesets)
	local tilewidth = level.tilewidth
	local tileheight = level.tileheight
	local index = 1
	for i, layer in ipairs(level.layers) do
		local layerGroup = display.newGroup()
		for row = 1, layer.height do
			for col = 1, layer.width do
				local gid = layer.data[index]
				createTile( 
					layerGroup, 
					tilesets, 
					gid,
					(col - 1) * tilewidth + tilewidth / 2,
					(row - 1) * tileheight + tileheight / 2)
				index = index + 1
			end
		end
		camera:add(layerGroup, i + 2) 
	end

	
	local player = redHeadGenerate({x=const.cx, y=const.cy, manager=manager})
	manager.setPlayer(player)
	camera:add(player.root, 2) 
	camera:setFocus(player.root)


	
	local controller = controllerGenerate(manager)
	sceneGroup:insert(controller.root) 
	
	local worldWidth = level.width * level.tilewidth
  local worldHeight = level.height * level.tileheight
	camera:setBounds(const.cx, worldWidth - const.cx, const.cy, worldHeight - const.cy)
	camera.damping = 10
	camera:track()

  manager.setWorldBoundary(worldWidth, worldHeight)
end


return load