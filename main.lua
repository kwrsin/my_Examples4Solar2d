require = require
local composer = require("composer")
local storage = require("libs.appStorage")
local inspect = require("libs.inspect")

function DEBUG(obj)
	print(inspect(obj))
end
storage.setPath('assets.levels.level01')
composer.gotoScene( 'scenes.title' )