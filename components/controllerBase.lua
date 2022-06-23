require = require
local const = require('libs.constants')
local generatorBase = require('game_objects.base')
local cur = nil
local btnA = nil
local btnB = nil

local radiusCursor = 16
local radiusBtnA = 10
local radiusBtnB = 10

local function isOutOfRange(distanceX, distanceY, radius)
	return distanceX * distanceX + distanceY * distanceY > radius * radius * 2 + radius * radius * 2
end
local function reset(event)
  event.target.alpha = 1
  display.getCurrentStage():setFocus( event.target, nil )
end
local function begin(event, distanceX, distanceY)
  event.target.alpha = 0.5
  display.getCurrentStage():setFocus( event.target, event.id )
end
local function cursor(group, radius, x, y)
	local cursorGroup = display.newGroup( )
	local cursorGO = display.newCircle(cursorGroup, 0, 0, radius * 2)
	cursorGO:setFillColor( 1.0, 0, 0 )
	cursorGroup.x = x
	cursorGroup.y = y
	cursorGroup:addEventListener( 'touch', function(event)
  	local distanceX = event.x - cursorGroup.x
  	local distanceY = event.y - cursorGroup.y
    if ( event.phase == "began" ) then
      begin(event, distanceX, distanceY)
			cur = {x = distanceX, y = distanceY}		
    elseif ( event.phase == "moved" ) then
    	if isOutOfRange(distanceX, distanceY, radius) then
        reset(event)
			  cur = nil
      else
	      begin(event, distanceX, distanceY)
				cur = {x = distanceX, y = distanceY}		
    	end
    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        reset(event)
			  cur = nil
    end
    return true		
	end )
	group:insert(cursorGroup)
end

local function buttonA(group, radius, x, y)
	local btnAGroup = display.newGroup( )
	local btnAGO = display.newCircle(btnAGroup, 0, 0, radius * 2)
	btnAGO:setFillColor( 1.0, 1.0, 0 )
	btnAGroup.x = x
	btnAGroup.y = y
	btnAGroup:addEventListener( 'touch', function(event)
  	local distanceX = event.x - btnAGroup.x
  	local distanceY = event.y - btnAGroup.y
    if ( event.phase == "began" ) then
      begin(event, distanceX, distanceY)
			btnA = {x = distanceX, y = distanceY}		
    elseif ( event.phase == "moved" ) then
    	if isOutOfRange(distanceX, distanceY, radius) then
        reset(event)
			  btnA = nil
      else
	      begin(event, distanceX, distanceY)
				btnA = {x = distanceX, y = distanceY}		
    	end
    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        reset(event)
			  btnA = nil
    end
    return true		
	end )
	group:insert(btnAGroup)
end

local function buttonB(group, radius, x, y)
	local btnBGroup = display.newGroup( )
	local btnBGO = display.newCircle(btnBGroup, 0, 0, radius * 2)
	btnBGO:setFillColor( 1.0, 0, 1.0 )
	btnBGroup.x = x
	btnBGroup.y = y
	btnBGroup:addEventListener( 'touch', function(event)
  	local distanceX = event.x - btnBGroup.x
  	local distanceY = event.y - btnBGroup.y
    if ( event.phase == "began" ) then
      begin(event, distanceX, distanceY)
			btnB = {x = distanceX, y = distanceY}		
    elseif ( event.phase == "moved" ) then
    	if isOutOfRange(distanceX, distanceY, radius) then
        reset(event)
			  btnB = nil
      else
	      begin(event, distanceX, distanceY)
				btnB = {x = distanceX, y = distanceY}		
    	end
    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        reset(event)
			  btnB = nil
    end
    return true		
	end )
	group:insert(btnBGroup)
end

local function generator(group, manager)
	local originTopLeft = {x=0, y=0}
	local base = generatorBase(group, originTopLeft)
	cursor(base.root, radiusCursor, 40, const.height - radiusCursor)
	buttonA(base.root, radiusBtnA, 220, const.height - radiusBtnA)
	buttonB(base.root, radiusBtnB, 280, const.height - radiusBtnB)

	function base:enterFrame(event)
		if cur == nil and btnA == nil and btnB == nil then
			manager.setButtonStatus(nil)
			return
		end
		manager.setButtonStatus({cur=cur, btnA=btnA, btnB=btnB})
	end
	function base.startEnterFrame()
		Runtime:addEventListener( 'enterFrame', base )
	end
	function base.stopEnterFrame()
		Runtime:removeEventListener( 'enterFrame', base )
	end
	base.startEnterFrame()

	return base
end

return generator