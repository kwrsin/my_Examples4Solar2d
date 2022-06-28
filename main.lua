require = require
local composer = require("composer")
local appStatus = require("libs.appStatus")
local inspect = require("libs.inspect")

function DEBUG(obj)
	print(inspect(obj))
end
appStatus.setPath('assets.levels.level01')
composer.gotoScene( 'scenes.title' )