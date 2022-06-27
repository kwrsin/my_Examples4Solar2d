require = require
local const = require('libs.constants')
local storage = require('libs.appStorage')
local perspective = require("components.perspective")
local controllerGenerate = require('components.controllerBase')
local bannerGenerate = require('game_objects.banners.banner')

local redHeadGenerate = require('game_objects.actors.redHead')
local reibaishiGenerate = require('game_objects.actors.reibaishi')
local physics = require('physics')

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

--[[
	Add Actors
	Don't forget a "return" after actor createing.
--]]
local function createTile(group, tilesets, gid, x, y, layerIndex, manager)
	function localIndex()
		return gid - 256 * (layerIndex - 1)
	end
	local lid = localIndex()
	function createATile()
		display.newImage(group, tilesets[gid], lid, x, y)
	end
	function createAWall()
		local aWall = display.newImage(group, tilesets[gid], lid, x, y)
		physics.addBody(aWall, 'static', {})
	end

	if gid == 256 + 2 + 1 then
		local reibaishi = reibaishiGenerate({x=x, y=y, manager=manager, disabled=true})
		group:insert(reibaishi.root)
	elseif gid == 64 + 1 then
		createAWall()
	else
		createATile()
	end
end

local function load(sceneGroup, manager)
	local camera = perspective.createView()
	sceneGroup:insert(camera)
	
	local level_path = storage.level_path
	local level = require(level_path)
	local tilesets = loadTiles(level.tilesets)
	local tilewidth = level.tilewidth
	local tileheight = level.tileheight
	for i, layer in ipairs(level.layers) do
		local index = 1
		local layerGroup = display.newGroup()
		for row = 1, layer.height do
			for col = 1, layer.width do
				local gid = layer.data[index]
				if gid > 0 then
					createTile( 
						layerGroup, 
						tilesets, 
						gid,
						(col - 1) * tilewidth + tilewidth / 2,
						(row - 1) * tileheight + tileheight / 2,
						i,
						manager)
				end
				index = index + 1
			end
		end
		camera:add(layerGroup, -i + 3) 
	end

	
	local player = redHeadGenerate({x=const.cx, y=const.cy, manager=manager, disabled=true})
	manager.setPlayer(player)
	camera:add(player.root, 1) 
	camera:setFocus(player.root)

	local banner = bannerGenerate({x=const.cx, y=const.cy, ready='assets/images/banners/ready.png', go='assets/images/banners/go.png', manager=manager})
	manager.setBanner(banner)
	sceneGroup:insert(banner.root)
	
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