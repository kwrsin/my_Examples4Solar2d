local const = require('libs.constants')
local composer = require('composer')
local dialogueGenerator = require('components.dialogue')

local scene = composer.newScene( )
local dialogue
local playing = false

function createButton(sceneGroup)
	local buttonGroup = display.newGroup( )
	sceneGroup:insert(buttonGroup)
	buttonGroup.x = const.cx
	buttonGroup.y = const.height
	local bg = display.newRoundedRect( buttonGroup, 0, 0, 200, 60, 30 )
	bg:setFillColor( 0.3, 0.4, 0.5 )
	local label = display.newText( buttonGroup, 'next', 0, 0, native.systemFont, 32 )
	buttonGroup:addEventListener( 'touch', function(event)
		if event.phase == 'began' then

		elseif event.phase == 'canceled' or event.phase == 'ended' then
			local color = nil
			if playing == false then
				dialogue.show('あなたはだれ？\n「まっくろくろすけ」？これは紛れもなくのりこむたの仕業かもしれません。あの天然の事故を引き起こしたのは奴に違いない！！早く逮捕しなければ、次々と犠牲者が増えていきます。',
					'新人刑事',
					'assets/images/standups/pinkhead.png',
					230,
					100,
					color,
					false,
					function()
						print('おしまい')
						playing = false
					end)
				playing = true
			else
				dialogue.flush()
			end
		end
	end )
end

function createBackground(sceneGroup)
	local background = display.newRect( sceneGroup, const.cx, const.cy, const.actualWidth, const.actualHeight )
	background:setFillColor( 0.2, 0.2, 1.0 )
end

function scene:create(event)
	local sceneGroup = scene.view
	createBackground(sceneGroup)
	dialogue = dialogueGenerator({group=sceneGroup, x=const.cx, y=const.cy - 100})

	createButton(sceneGroup)
end

function scene:show(event)
	local sceneGroup = scene.view
	if event.phase == 'will' then
	elseif event.phase == 'did' then
	end
end

function scene:hide(event)
	local sceneGroup = scene.view
	if event.phase == 'will' then
	elseif event.phase == 'did' then
	end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
return scene