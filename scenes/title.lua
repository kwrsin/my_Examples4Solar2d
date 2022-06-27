-- title.lua
require = require
local composer = require('composer')

local const = require('libs.constants')

local scene = composer.newScene( )

--TODO: dialogue&timer&status
local controllerGenerate = require('components.controllerBase')
local controller = controllerGenerate(nil)
display.getCurrentStage():insert( controller.root )

local function bigger(obj, flip)
  local params
  if flip then
    params = {tag='bigger', iterations=1,transition=easing.outSine, xScale=1.0, yScale=1.0, time=500, 
      onComplete=function(obj) 
        bigger(obj, not flip) 
      end}
  else
    params = {tag='bigger', iterations=1,transition=easing.outSine, xScale=1.1, yScale=1.1, time=500, 
      onComplete=function(obj) 
        bigger(obj, not flip) 
      end}
  end
  transition.scaleTo(obj, params)
end
local function createTitle(group)
	local function createStartButton(group)
		local buttonGroup = display.newGroup()
		buttonGroup.x =  const.cx
		buttonGroup.y = const.cy + 160
		local button = display.newRoundedRect( buttonGroup, 0, 0, 120, 60, 30 )
		button:setFillColor( 12/ 255, 128 / 255, 128 / 255 )

      local label = display.newText(buttonGroup, 'スタート', 0, 0, system.nativeFont, 24)
      group:insert(buttonGroup)
      group:addEventListener( 'touch', function(event)
        transition.cancel()
        composer.gotoScene( 'scenes.game', { effect="slideRight", time=800, params={controller=controller} } )
      end )
      bigger(buttonGroup, false)
    end

	local background = display.newRect(const.cx, const.cy, const.actualWidth, const.actualHeight)
	background:setFillColor( 128 / 255, 10 / 255, 40 / 255 )
	group:insert(background)
	local title = display.newText( 'ハローワールド', const.cx, const.cy, system.nativeFont, 32)
	group:insert(title)
	createStartButton(group)
end

function createLogo(sceneGroup)
  local logoGroup = display.newGroup()
  local logoGO = display.newImage(logoGroup, 'assets/images/title/title2.png', 0, 0)
  logoGroup.x = const.cx
  logoGroup.y = const.cy
  sceneGroup:insert(logoGroup)
end

function scene:create(event)
	local sceneGroup = scene.view
	createTitle(sceneGroup)
  createLogo(sceneGroup)
end

function scene:show(event)
	if event.phase == 'will' then
	elseif event.phase == 'did' then
	end
end

function scene:hide(event)
	if event.phase == 'will' then
	elseif event.phase == 'did' then
	end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene
