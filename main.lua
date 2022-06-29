local composer = require("composer")
-- local appStatus = require("libs.appStatus")
local inspect = require("libs.inspect")
-- local controllerGenerate = require('components.controllerBase')

function DEBUG(obj)
	print(inspect(obj))
end

-- local controller = controllerGenerate()
-- display.getCurrentStage():insert( controller.root )
-- appStatus.setPath('assets.levels.level01')
-- appStatus.setController(controller)
-- composer.gotoScene( 'scenes.title' )
composer.gotoScene( 'scenes.tests.chatScene' )