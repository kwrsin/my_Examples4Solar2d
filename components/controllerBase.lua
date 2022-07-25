local const = require('customize.constants')
local utils = require('libs.utils')
local generatorBase = require('customize.game_objects.base')
local appStatus = require('customize.appStatus')
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
	return cursorGroup
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
	return btnAGroup
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
	return btnBGroup
end

-- keyInput
local function keyInput(event)
	if appStatus.manager == nil then return end
	if appStatus.manager.player == nil then return end
	if appStatus.manager.player.disabled == true then return end
	if event.phase == 'down' then
		if event.keyName == 'up' then
			cur = {x=0, y=-1}
		elseif event.keyName == 'down' then
			cur = {x=0, y=1}
		elseif event.keyName == 'left' then
			cur = {x=-1, y=0}
		elseif event.keyName == 'right' then
			cur = {x=1, y=0}
		elseif event.keyName == 'a' then
			btnA = {x=0, y=0}
		elseif event.keyName == 'b' then
			btnB = {x=0, y=0}
		end
	elseif event.phase == 'up' then
		if event.keyName == 'up' then
			cur = nil
		elseif event.keyName == 'down' then
			cur = nil
		elseif event.keyName == 'left' then
			cur = nil
		elseif event.keyName == 'right' then
			cur = nil
		elseif event.keyName == 'a' then
			btnA = nil
		elseif event.keyName == 'b' then
			btnB = nil
		end
	end
end

local function generator(options)
	local originTopLeft = options or {}
	originTopLeft.y = originTopLeft.y or 100
	local base = generatorBase(originTopLeft)
	base.cursorGroup = cursor(base.root, radiusCursor, 40, const.height - radiusCursor)
	base.btnAGroup = buttonA(base.root, radiusBtnA, 220, const.height - radiusBtnA)
	base.btnBGroup = buttonB(base.root, radiusBtnB, 280, const.height - radiusBtnB)
	
	function base:enterFrame(event)
		if appStatus.manager == nil then return end
		if appStatus.manager.player == nil then return end
		if appStatus.manager.player.disabled == true then return end
		if cur == nil and btnA == nil and btnB == nil then
			appStatus.manager.setButtonStatus(nil)
			return
		end
		appStatus.manager.setButtonStatus({cur=cur, btnA=btnA, btnB=btnB})
	end
	function base.show()
		if utils.isSimulator() then
			Runtime:addEventListener( 'key', keyInput )
		end
		transition.moveTo( base.root, {y=0, time=500, transition=easing.outBounce, onComplete=function()
		end})
	end
	function releaseAll()
		reset({target=base.cursorGroup})
		reset({target=base.btnAGroup})
		reset({target=base.btnBGroup})
		cur = nil
		btnA = nil
		btnB = nil
	end
	function base.hide()
		if utils.isSimulator() then
			Runtime:removeEventListener( 'key', keyInput )
		end
		-- transition.moveTo( base.root, {y=offset, time=500} )
		releaseAll()
		base.root.x = originTopLeft.x
		base.root.y = originTopLeft.y
	end

	return base
end

return generator