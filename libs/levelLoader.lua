local const = require('libs.constants')
local appStatus = require('libs.appStatus')
local perspective = require("components.perspective")
local bannerGenerate = require('game_objects.banners.banner')
local gameoverGenerate = require('game_objects.banners.gameover')

local redHeadGenerate = require('game_objects.actors.redHead')
local reibaishiGenerate = require('game_objects.actors.reibaishi')
local reibaishiGenerate = require('game_objects.actors.reibaishi')
local goalGenerate = require('game_objects.doors.goal')
local physics = require('physics')
local level
local localIndice

local function imageSheet(tileset)
	return graphics.newImageSheet( const.tilesetPath .. tileset.image, {
			width = tileset.tilewidth,
			height = tileset.tileheight,
			numFrames = tileset.tilecount,
			sheetContentWidth = tileset.imagewidth,
			sheetContentHeight = tileset.imageHeight,
		} )
end

local function multiPolygon(tileset, width, height)
	local meshList = {}
	local tiles = tileset.tiles
	if tiles and #tiles > 0 then
		for i, tile in ipairs(tiles) do
			local mesh = {}
			mesh.gid = tileset.firstgid + tile.id
			local objectGroup = tile.objectGroup
			if objectGroup and objectGroup.type == 'objectgroup' then
				local objects = objectGroup.objects
				local colliderList = {}
				for j, object in ipairs(objects) do
					if object.shape == 'polygon' and #object.polygon > 0 then
						local vertexList = {}
						for k, vertex in ipairs(object.polygon) do
							vertexList[#vertexList + 1] = vertex.x - width / 2 + object.x
							vertexList[#vertexList + 1] = vertex.y - height / 2 + object.y
						end
						colliderList[#colliderList + 1] = vertexList
					elseif object.shape == 'rectangle' then
						-- TODO: other shape
					end
				end
				mesh.colliderList = colliderList

			else
				-- TODO: a single object
			end
			meshList[#meshList + 1] = mesh
		end
	end
	return meshList
end

local function loadColliders(tilesets)
	local mpList = {}
	for i, tileset in ipairs(tilesets) do
		local mpvalues = multiPolygon(tileset, tileset.tilewidth, tileset.tileheight)
		for j, mp in ipairs(mpvalues) do
			mpList[mp.gid] = mp.colliderList
		end
	end	
	return mpList
end

local function loadTiles(tilesets)
	local tilesetList = {}
	for _, tileset in ipairs(tilesets) do
		local firstgid = tileset.firstgid
		local is = imageSheet(tileset)
		for i = 1, tileset.tilecount do
			local data = {}
			data.imageSheet = is
			data.lid = i
			tilesetList[firstgid + i -1] = data
		end
	end
	return tilesetList
end

--[[
	Add Actors and Obstacles
	Don't forget a "return" after actor createing.
--]]
local function createTile(group, tilesetData, gid, x, y, colliders)
	function localIndex()
		local baseNumber = 0
		for _, tileset in ipairs(tilesets) do
			if baseNumber < gid then
				baseNumber = tileset.tilecount + baseNumber
			end
		end

		-- local idx = 1
		-- repeat 
		-- 		baseNumber = tilesets[idx].firstgid - 1
		-- 		idx = idx + 1
		-- until tilesets[idx].firstgid < gid
		return gid % 256
	end
	local lid = tilesetData[gid].lid
	function createATile()
		display.newImage(group, tilesetData[gid].imageSheet, lid, x, y)
	end
	function createAWall()
		local aWall = display.newImage(group, tilesetData[gid].imageSheet, lid, x, y)
		physics.addBody(aWall, 'static', {})
	end
	function createAWallWithPolygon()
		local aWall = display.newImage(group, tilesetData[gid].imageSheet, lid, x, y)
		local gidCollider = colliders[gid]
		local multiCollider = {}
		for _, collider in ipairs(gidCollider) do
			multiCollider[#multiCollider + 1] = {shape=collider}
		end
		-- https://stackoverflow.com/questions/14474206/is-there-a-lua-equivalent-of-javascripts-apply
		physics.addBody(aWall, 'static', unpack(multiCollider))
	end

	if gid == 256 + 60 + 0 + 1 then
		createAWallWithPolygon()
	elseif gid == 256 + 3 + 1 then
		createAWallWithPolygon()
	elseif gid == 256 + 0 + 1 then
		redHeadGenerate({group=group, x=x, y=y, disabled=true, scenario_index=const.scenario_hello})
	elseif gid == 256 + 2 + 1 then
		reibaishiGenerate({group=group, x=x, y=y, disabled=true, isPlayer=true})
	elseif gid == 183 + 1 then
		goalGenerate(tilesetData[gid].imageSheet, lid, {group=group, x=x, y=y, role=const.role_item})
	elseif gid == 64 + 1 then
		createAWall()
	else
		createATile()
	end
end

local function load(sceneGroup)
	local camera = perspective.createView()
	sceneGroup:insert(camera)
	appStatus.manager.setCamera(camera)
	
	local level_path = appStatus.level_path
	level = require(level_path)
	local tilesetData = loadTiles(level.tilesets)
	local colliders = loadColliders(level.tilesets)
	local tilewidth = level.tilewidth
	local tileheight = level.tileheight
	for i, layer in ipairs(level.layers) do
		local index = 1
		local layerGroup = display.newGroup()
		if layer.type == const.layerType_tile then
			-- TILE LAYER
			for row = 1, layer.height do
				for col = 1, layer.width do
					local gid = layer.data[index]
					if gid > 0 then
						createTile( 
							layerGroup, 
							tilesetData, 
							gid,
							(col - 1) * tilewidth + tilewidth / 2,
							(row - 1) * tileheight + tileheight / 2,
							colliders)
					end
					index = index + 1
				end
			end
		elseif layer.type == const.layerType_object then
		-- OBJECT LAYER
			local objects = layer.objects
			for _, object in ipairs(objects) do
				local gid = object.gid
				createTile( 
					layerGroup, 
					tilesetData, 
					gid,
					object.x + object.width / 2,
					object.y - object.height / 2,
					colliders)
			end	
		end
		camera:add(layerGroup, -i + #level.layers + 4) 
	end
	
	local banner = bannerGenerate({x=const.cx, y=const.cy, ready='assets/images/banners/ready.png', go='assets/images/banners/go.png'})
	appStatus.manager.setBanner(banner)
	sceneGroup:insert(banner.root)

	local gameover = gameoverGenerate({x=const.cx, y=0 - 200})
	appStatus.manager.setGameOver(gameover)
	sceneGroup:insert(gameover.root)
		
	
	local worldWidth = level.width * level.tilewidth
  local worldHeight = level.height * level.tileheight
	camera:setBounds(const.cx, worldWidth - const.cx, const.cy, worldHeight - const.cy)
	camera.damping = 10
	camera:track()

  appStatus.manager.setWorldBoundary(worldWidth, worldHeight)
end


return load