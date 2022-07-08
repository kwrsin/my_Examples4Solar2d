-- levelLoader.lua
local const = require('customize.constants')
local appStatus = require('customize.appStatus')
local M = require('libs.loader')

local bannerGenerate = require('customize.game_objects.banners.banner')
local gameoverGenerate = require('customize.game_objects.banners.gameover')
local redHeadGenerate = require('customize.game_objects.actors.redHead')
local reibaishiGenerate = require('customize.game_objects.actors.reibaishi')
local goalGenerate = require('customize.game_objects.doors.goal')

--[[
	Add Actors and Obstacles
--]]
function M.createTile(group, tilesetData, gid, x, y, colliders)
	local lid = tilesetData[gid].lid

	if gid == 256 + 60 + 0 + 1 then
		M.createAWallWithPolygon(group, tilesetData[gid].imageSheet, lid, x, y, colliders[gid])
	elseif gid == 256 + 3 + 1 then
		M.createAWallWithPolygon(group, tilesetData[gid].imageSheet, lid, x, y, colliders[gid])
	elseif gid == 256 + 0 + 1 then
		redHeadGenerate({group=group, x=x, y=y, disabled=true, isPlayer=true})
	elseif gid == 256 + 2 + 1 then
		reibaishiGenerate({group=group, x=x, y=y, disabled=true, scenario_index=const.scenario_hello})
	elseif gid == 183 + 1 then
		goalGenerate(tilesetData[gid].imageSheet, lid, {group=group, x=x, y=y, role=const.role_item})
	elseif gid == 64 + 1 then
		M.createAWall(group, tilesetData[gid].imageSheet, lid, x, y)
	else
		M.createATile(group, tilesetData[gid].imageSheet, lid, x, y)
	end
end

function M.afterLoaded(sceneGroup)
	local banner = bannerGenerate({x=const.cx, y=const.cy, ready='assets/images/banners/ready.png', go='assets/images/banners/go.png'})
	appStatus.manager.setBanner(banner)
	sceneGroup:insert(banner.root)

	local gameover = gameoverGenerate({x=const.cx, y=0 - 200})
	appStatus.manager.setGameOver(gameover)
	sceneGroup:insert(gameover.root)
end


return M.load