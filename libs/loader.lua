local const = require('customize.constants')
local appStatus = require('customize.appStatus')
local perspective = require("components.perspective")
local physics = require('physics')

local M = {}

local function imageSheet(tileset)
	return graphics.newImageSheet( const.tilesetPath .. tileset.image, {
			width = tileset.tilewidth,
			height = tileset.tileheight,
			numFrames = tileset.tilecount,
			sheetContentWidth = tileset.imagewidth,
			sheetContentHeight = tileset.imageHeight,
		} )
end

local function toVertex(object, width, height)
		if object.shape == 'polygon' and #object.polygon > 0 then
			local vertexList = {}
			for k, vertex in ipairs(object.polygon) do
				vertexList[#vertexList + 1] = vertex.x - width / 2 + object.x
				vertexList[#vertexList + 1] = vertex.y - height / 2 + object.y
			end
			return vertexList
		elseif object.shape == 'rectangle' then
			-- TODO: other shape
		end
		return nil
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
					colliderList[#colliderList + 1] = toVertex(object, width, height)
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

function createShapeCollider(group, object)
	function createShapeGroup()
		local shapeGroup = display.newGroup()
		shapeGroup.x = object.x + object.width / 2
		shapeGroup.y = object.y + object.height / 2
		group:insert(shapeGroup)
		return shapeGroup
	end
	function createARectCollider()
		local shape = createShapeGroup()
		physics.addBody(shape, 'static', {box={halfWidth=object.width / 2, halfHeight=object.height / 2}})
	end
	function createAPolygonCollider()
		local shape = createShapeGroup()
		local maxPosX = 0
		local minPosX = 0
		local maxPosY = 0
		local minPosY = 0
		local bondaryWidth = 0
		local boundaryHeight= 0
		for _, pol in ipairs(object.polygon) do
			if pol.x > maxPosX then maxPosX = pol.x end
			if pol.x < minPosX then minPosX = pol.x end
			if pol.y > maxPosY then maxPosY = pol.y end
			if pol.y < minPosY then minPosY = pol.y end
		end
		bondaryWidth = maxPosX - minPosX
		bondaryHeight = maxPosY - minPosY
		object.x = bondaryWidth / 2
		object.y = bondaryHeight / 2
		local vertex = toVertex(object, bondaryWidth, bondaryHeight)

		physics.addBody(shape, 'static', {chain=vertex, connectFirstAndLastChainVertex = true})		
	end
	-- transparent shape
	if object.shape == 'rectangle' then
		createARectCollider()
	elseif object.shape == 'polygon' then
		createAPolygonCollider()
	end
end

function M.createATile(group, imageSheet, lid, x, y)
	display.newImage(group, imageSheet, lid, x, y)
end
function M.createAWall(group, imageSheet, lid, x, y)
	local aWall = display.newImage(group, imageSheet, lid, x, y)
	physics.addBody(aWall, 'static', {})
end
function M.createAWallWithPolygon(group, imageSheet, lid, x, y, gidCollider)
	local aWall = display.newImage(group, imageSheet, lid, x, y)
	local multiCollider = {}
	for _, collider in ipairs(gidCollider) do
		multiCollider[#multiCollider + 1] = {shape=collider}
	end
	-- https://stackoverflow.com/questions/14474206/is-there-a-lua-equivalent-of-javascripts-apply
	physics.addBody(aWall, 'static', unpack(multiCollider))
end

function M.createTile(group, tilesetData, gid, x, y, colliders)
end

function M.afterLoaded(sceneGroup)
end

function M.load(sceneGroup)
	local camera = perspective.createView()
	sceneGroup:insert(camera)
	appStatus.manager.setCamera(camera)
	
	local level_path = appStatus.level_path
	local level = require(level_path)
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
						M.createTile( 
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
				if tilesetData[gid] then
					M.createTile( 
						layerGroup, 
						tilesetData, 
						gid,
						object.x + object.width / 2,
						object.y - object.height / 2,
						colliders)
				else
					createShapeCollider(layerGroup, object)
				end
			end	
		end
		camera:add(layerGroup, -i + #level.layers + 4) 
	end
	
	M.afterLoaded(sceneGroup)		
	
	local worldWidth = level.width * level.tilewidth
  local worldHeight = level.height * level.tileheight
	camera:setBounds(const.cx, worldWidth - const.cx, const.cy, worldHeight - const.cy)
	camera.damping = 10	
	camera:track()

  appStatus.manager.setWorldBoundary(worldWidth, worldHeight)
end

return M