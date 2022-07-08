-- ui.lua
local const = require('libs.constants')
local generateBase = require('customize.game_objects.base')
local confirm = require('components.ui.confirm')
local base
local body
local frame

local function clear()
	body:removeSelf( )
	body = nil
end

local function getBody(group)
	body = display.newGroup()
	group:insert(body)
	return body
end

local function generate(options)
	base = generateBase(options)

	function base.confirm(callback)
		body = getBody(base.root)
		function finalize(value)
				transition.scaleTo( body, {time=30, yScale=0.1, alpha=0, iterations=1, onComplete=function()
					if callback then
						callback(value)
						clear()
					end
				end} )
		end
		confirm(body, finalize)
		body.alpha = 0
		-- TODO: play a sound
		transition.scaleTo( body, {time=300, yScale=1.0, alpha=1, transition=easing.outBounce, iterations=1} )
	end

	return base
end


return generate