local composer = require("composer")
local appStatus = require("libs.appStatus")
local inspect = require("libs.inspect")
local controllerGenerate = require('components.controllerBase')
local dialogueGenerate = require('components.dialogue')
local uiGenerator = require('components.ui')

local const = require('libs.constants')
local manager = require('managers.manager')

function DEBUG(obj)
	print(inspect(obj))
end

local dialogue = dialogueGenerate({x=const.cx, y=const.cy - 100})
display.getCurrentStage():insert( dialogue.root )
appStatus.setDialogue(dialogue)

local controller = controllerGenerate()
display.getCurrentStage():insert( controller.root )
appStatus.setController(controller)

local ui = uiGenerator({x=const.cx, y=const.cy})
display.getCurrentStage():insert( ui.root )
appStatus.setUI(ui)

appStatus.setManager(manager)

appStatus.setPath('assets.levels.level01')

composer.gotoScene( 'scenes.title' )





-- composer.gotoScene( 'scenes.tests.chatScene' )
-- composer.gotoScene( 'scenes.tests.uiScene' )
