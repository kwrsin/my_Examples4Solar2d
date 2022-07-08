-- confirm.lua
local sheetData = require('assets.images.ui.buttons.ui').sheetData
local is = graphics.newImageSheet( 
	'assets/images/ui/buttons/ui.png', sheetData)
local const = require('customize.constants')

local function createFrame(body, width, height)
	local background = display.newRect( body, 0, 0, const.actualWidth, const.actualHeight )
	background:setFillColor( 0, 0, 0, 0.6 )
	background:addEventListener('touch', function(event) 
		return true --stop propagetion
	end)
		local halfWidth = width / 2
	local halfHeight = height / 2
	local mid =         display.newImage(body, is, 5,          0,           0)
	local left =        display.newImage(body, is, 4, -halfWidth,           0)
	local right =       display.newImage(body, is, 6,  halfWidth,           0)
	local buttom =      display.newImage(body, is, 1,          0,  halfHeight)
	local buttomleft =  display.newImage(body, is, 2, -halfWidth,  halfHeight)
	local buttomright = display.newImage(body, is, 3,  halfWidth,  halfHeight)
	local top =         display.newImage(body, is, 7,          0, -halfHeight)
	local topleft =     display.newImage(body, is, 8, -halfWidth, -halfHeight)
	local topright =    display.newImage(body, is, 9,  halfWidth, -halfHeight)
	buttom.xScale = width / buttom.width
	top.xScale = width / top.width
	left.yScale = height / left.height
	right.yScale = height / right.height
	mid.xScale = width / buttom.width
	mid.yScale = height / left.height
end

local function createConfirmButton(body, frameWidth, frameHeight, callback)
	local function onTouch(event)
		if event.phase == 'began' then
		elseif event.phase == 'ended' or event.phase == 'canceled' then
			if callback then
				callback(event.target.name)
			end
		end
	end
	local offset = 12
	local idx = offset
	local options = {
		sheetData.frames[idx],
		sheetData.frames[idx + 1]
	}
	options[1].name = 'no'
	options[2].name = 'yes'
	local xPos = 0
	local padding = 20
	local unit = #options * 2
	local fragmentHeight = (frameHeight - padding) / unit
	for i = 1, unit do
		if i % 2 == 0 then
		else
			local buttonGroup = display.newGroup()
			body:insert(buttonGroup)
			display.newImage(buttonGroup, is, idx, 0, (i - 1) * fragmentHeight - fragmentHeight)
			buttonGroup.name = options[idx - offset + 1].name
			buttonGroup:addEventListener( 'touch', onTouch )
			idx = idx + 1
		end
	end
end



function confirm(body, callback)
	local frameWidth = 140
	local frameHeight = 220

	createFrame(body, frameWidth, frameHeight)
	createConfirmButton(body, frameWidth, frameHeight, callback)

end

return confirm