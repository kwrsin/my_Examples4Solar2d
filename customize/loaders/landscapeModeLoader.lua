-- landscapeModeLoader.lua
local const = require('customize.constants')
local appStatus = require('customize.appStatus')

local redHeadGenerate = require('customize.game_objects.actors.redHead')
local frogGenerate = require('customize.game_objects.actors.frog')
local crowGenerate = require('customize.game_objects.actors.crow')

local M = require('libs.loader')

function M.createTile(group, tilesetData, gid, x, y, colliders)
	local lid = tilesetData[gid].lid
	if gid == 150 + 0 + 1 then
		redHeadGenerate({group=group, x=x, y=y, role=const.role_enemy, isPlayer=true, disabled=false})
	elseif gid == 150 + 0 + 2 then
		frogGenerate({group=group, x=x, y=y, disabled=false, role=const.role_enemy, skill='frogWeapon'})
	elseif gid == 150 + 0 + 3 then
		crowGenerate({group=group, x=x, y=y, disabled=false, role=const.role_enemy, skill='crowWeapon'})
	else
		M.createATile(group, tilesetData[gid].imageSheet, lid, x, y)
	end
end

function M.afterLoaded(sceneGroup)
end

return M.load