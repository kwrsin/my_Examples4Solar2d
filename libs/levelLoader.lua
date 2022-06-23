
require = require
local const = require('libs.constants')
local storage = require('libs.appStorage')

local function imageSheet(tileset)
	return graphics.newImageSheet( const.imagePath .. tileset.image, {
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

local function load(cameraGroup)
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
		cameraGroup:insert(layerGroup)
	end
end


return load