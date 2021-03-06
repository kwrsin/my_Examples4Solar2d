-- title.lua
local composer = require('composer')

local const = require('customize.constants')
local sounds = require('libs.sounds')

local scene = composer.newScene( )
local buttonGroup

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
		buttonGroup = display.newGroup()
		buttonGroup.x =  const.cx
		buttonGroup.y = const.cy + 160
		local button = display.newRoundedRect( buttonGroup, 0, 0, 120, 60, 30 )
		button:setFillColor( 12/ 255, 128 / 255, 128 / 255 )
    local isFocus
    local label = display.newText(buttonGroup, 'スタート', 0, 0, system.nativeFont, 24)
    group:insert(buttonGroup)
    buttonGroup:addEventListener( 'touch', function(event)
      if event.phase == "began" then
        display.getCurrentStage():setFocus( buttonGroup )
        isFocus = true
      elseif isFocus then
        if event.phase == "ended" or event.phase == "cancelled"  then
          display.getCurrentStage():setFocus( nil )
          isFocus = nil
          composer.gotoScene( 'customize.scenes.game' )
        end
      end
    end )
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
  bigger(buttonGroup, true)
end

function scene:show(event)
  local sceneGroup = scene.view
	if event.phase == 'will' then
    sounds.rewindBGM(const.bgm)
    sounds.playBMG(const.bgm)
	elseif event.phase == 'did' then
	end
end

function scene:hide(event)
	if event.phase == 'will' then
    sounds.stop()
	elseif event.phase == 'did' then
	end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene
