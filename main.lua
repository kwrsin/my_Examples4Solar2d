local composer = require("composer")
local const = require("customize.constants")
local utils = require("libs.utils")
local appStatus = require("customize.appStatus")
local inspect = require("libs.inspect")
local sounds = require("libs.sounds")
local controllerGenerate = require('components.controllerBase')
local dialogueGenerate = require('components.dialogue')
local uiGenerator = require('components.ui')

local const = require('customize.constants')
local manager = require('customize.managers.manager')

function DEBUG(obj)
	if utils.isSimulator() then
		print(inspect(obj))
	end
end

-- add componets to appStatus
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

-- add Sound files
sounds.addBGM(const.bgm)
sounds.addSE(const.walking)

-- composer.gotoScene( 'customize.scenes.title' )
composer.gotoScene( 'customize.scenes.tests.testScene' )
-- composer.gotoScene( 'customize.scenes.tests.testScene2' )
-- composer.gotoScene( 'customize.scenes.tests.donkeyLike' )