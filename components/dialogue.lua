-- dialogue.lua
local const = require('libs.constants')
local baseGenerator = require('customize.game_objects.base')
local utils = require('libs.utils')

local STATE_READY = 0
local STATE_DONE = 1
local STATE_RUNNNING = 2
local BLINK_TAG = 'blinkPrompt'

local base
local dialogue = ''
local dialogue_source = ''
local dialogue_array = {}
local dialogue_counter = 1
local dialogue_timer
local name
local image_path = ''
local duration = 100
local textColor = {255, 255, 255}
local trigger = nil
local flushout = false
local text
local image
local prompt
local needPrompt = false
local triggerDone = false
local state = STATE_READY

local container
local containerWidth
local containerHeight

local function clear()
	dialogue = ''
	dialogue_source = ''
	dialogue_array = {}
	dialogue_counter = 1
	if name then
		name.text = ''
	end
	duration = 100
	textColor = {255, 255, 255}
	singal = nil
	flushout = false
	if text then
		text.text = ''
	end
	needPrompt = false
	triggerDone = false
	state = STATE_READY
end

local function isEndDialogue()
	return dialogue_counter >= #dialogue_array
end

local function createPrompt(group)
	if prompt then
		prompt.alpha = 0
		prompt.yScale = 0.1
		return
	end
	prompt = display.newText(group, '🤍', 0, 0, native.systemFont, 12)
	prompt:setFillColor( 255, 0, 0 )
	prompt.alpha = 0
	prompt.yScale = 0.1
	prompt.x = 100
	prompt.y = 100	
end

local function showPrompt()
	if not needPrompt then return end
		transition.scaleTo(prompt, {time=20, yScale=1.0, alpha=1, iterations=1, transition=easing.outElastic, onComplete=function()
			transition.blink( prompt, {tag=BLINK_TAG, time=2000 } )

		end})
end

local function hidePrompt()
	transition.cancel(BLINK_TAG)
	transition.scaleTo(prompt, {time=200, yScale=0.1, alpha=0, iterations=1, transition=easing.outElastic})
end

local function removeImage()
	if image then
		image:removeSelf( )
		image = nil
	end
end

local function generate(options)
	base = baseGenerator(options)
	local textWidth = options.width or 240
	local textHeight = options.height or 240
	local font = options.font or native.systemFont
	local fontSize = options.size
	containerWidth = options.containerWidth or const.width - 40
	containerHeight = options.containerHeight or const.height / 2
	container = display.newContainer( base.root, containerWidth, containerHeight)
	local background = display.newRoundedRect( container, 0, 0, containerWidth, textHeight, 20 )
	background:setFillColor( 0.1, 0.1, 0.1, 0.8 )
	container.yScale = 0.1
	container.alpha = 0
	text = display.newText( container, dialogue, 0, 60, textWidth, textHeight, native.systemFont, fontSize )
	text:setFillColor( unpack(textColor) )
	name = display.newText( container, '', 0, -textHeight / 2 + 30, native.systemFont, 32 )
	name.anchorX = 1
	createPrompt( base.root )

	function base.show2(options)
		base.show(
			options.data, 
			options.name, 
			options.image_path, 
			options.imageYpos, 
			options.duration, 
			options.color, 
			options.needPrompt, 
			options.trigger
		)
	end

	function base.show(data, pName, pImage_path, imageYpos, pDuration, pColor, pNeedPrompt, pTrigger)
		needPrompt = pNeedPrompt
		text.text = ''
		if name.text ~= pName then
			name.text = ''
		end
		if pImage_path and image_path ~= pImage_path then
			removeImage()
			image = display.newImage( base.root, pImage_path)
			image.y = imageYpos
			image.alpha = 0
			image_path = pImage_path
			transition.to( image, {alpha=1.0, time=500, iterations=1} )
		elseif pImage_path and image_path == pImage_path then
			image.alpha = 1.0
		elseif not pImage_path then
			removeImage()			
		end
		if pName == name then
			base.speak(data, pName, pImage_path, imageYpos, pDuration, pColor, pNeedPrompt, pTrigger)
		else
			transition.scaleTo(container, {time=500, yScale=1.0, alpha=1, iterations=1, transition=easing.outElastic,
				onComplete=function()
					base.speak(data, pName, pImage_path, imageYpos, pDuration, pColor, pNeedPrompt, pTrigger)
				end})
		end
	end

	function base.hide()
		transition.scaleTo(container, {time=500, yScale=0.1, alpha=0, iterations=1, 
			onComplete=function()
				if trigger and triggerDone == false then
					trigger()
					triggerDone = true
				end
			end})
		transition.to(image, {time=500, alpha=0, iterations=1})
		hidePrompt()
	end

	function base.speak(data, pName, pImage_path, imageYpos, pDuration, pColor, pNeedPrompt, pTrigger)
		clear()
		state = STATE_RUNNNING
		dialogue_source = data
		needPrompt = pNeedPrompt
		dialogue_array = utils.toArray(data)
		if pName then
			name.text = pName
		end

		duration = pDuration or duration
		if pColor then
			text:setFillColor( unpack(pColor) )
		else
			text:setFillColor( unpack(textColor) )
		end
		trigger = pTrigger
		base.voice()
	end

	function base.voice()
		local function Body()
			for i = 1, #dialogue_array do
				dialogue = dialogue .. dialogue_array[dialogue_counter]
				dialogue_counter = dialogue_counter + 1
				text.text = dialogue
				-- TODO: play a sound
				if isEndDialogue() then
					state = STATE_DONE
					if trigger and flushout == false then
						if not needPrompt then
							trigger()
							triggerDone = true
						end
						showPrompt()
					end
					flushout = true
				end
				coroutine.yield()
			end
		end

		if isEndDialogue() then return end

		if #dialogue_array > 0 then
			dialogue_timer = 
				timer.performWithDelay( duration, coroutine.wrap(Body), #dialogue_array )
		end
	end

	function base.flush()
		if state == STATE_RUNNNING then
			if dialogue_timer then
				timer.cancel(dialogue_timer)
				dialogue_counter = #dialogue_array
				text.text = dialogue_source
				state = STATE_DONE
				if trigger and flushout == false then
					if not needPrompt then
						trigger()
						triggerDone = true
					end
					showPrompt()
				end
				flushout = true
			end
		elseif state == STATE_DONE then
			if not needPrompt then
			 base.hide()
			else
				if trigger and triggerDone == false then
					trigger()
					triggerDone = true
				end
				hidePrompt()				
			end
		end
	end

	function base.next()
		if trigger and triggerDone == false then
			trigger()
		end
	end

	return base
end

return generate