-- uiScene.lua
local composer = require('composer')
local uiGenerator = require('components.ui')
local const = require('customize.constants')

local scene = composer.newScene( )
local ui = uiGenerator({x=const.cx, y=const.cy})

local function createBtn(parent, name, x, y, callback) 
	local cbGroup = display.newGroup( )
	local bg = display.newRoundedRect( cbGroup, 0, 0, 200, 60, 30 )
	bg:setFillColor( 0.3, 0.5, 0.4 )
	local text = display.newText( cbGroup, name, 0, 0, native.systemFont, 24 )
	text:setFillColor( 1, 1, 1 )
	cbGroup.x = x
	cbGroup.y = y
	cbGroup:addEventListener( 'touch', function(event) 
		if event.phase == 'ended' or event.phase == 'canceled' then
			if callback then
				callback(event, name)
			end
		end
	end)
	parent:insert(cbGroup)
end

function scene:create(event)
	local sceneGroup = self.view

	createBtn(sceneGroup, "confirm", const.cx, const.height - 30, function(event, name)
		ui.confirm(function(value)
			DEBUG('close confirm '.. value) 
		end)
	end)
end

function scene:show(event)
	local sceneGroup = self.view
	if event.phase == 'will' then
	elseif event.phse == 'did' then
	end
end

function scene:hide(event)
	if event.phase == 'will' then
	elseif event.phse == 'did' then
	end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene