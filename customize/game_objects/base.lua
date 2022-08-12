-- base.lua
local const = require('customize.constants')
local appStatus = require('customize.appStatus')

local function generate(options)
	local base  = {}
	function base.reset()
		if base.options then
			for key, option in pairs(base.options) do
				base[key] = option
			end
			base.root.x = base.options.x
			base.root.y = base.options.y
			base.isPlayer = base.options.isPlayer or false
			base.disabled = base.options.disabled or false
			base.group = base.options.group
			if base.isPlayer then
				base.root._role = const.role_player
			else
				base.root._role = base.options.role or const.role_npc	
			end
			base.root._scenario_index = base.options.scenario_index
		end
		base.setup()
	end
	function base.setup()
	end
	function base.clear()
	end
	function base.play(name)
		if not base.sprite then return end
		if base.sprite.sequence == name and base.sprite.isPlaying then return end
		base.sprite:setSequence(name)
		base.sprite:play()
	end
	function base.stopTransition()
		transition.cancel( base.tagName )
	end
	function base.vanish()
		base.stopTransition()
		base.clear()
	end
	function base.hasCollidedRect( obj1, obj2 )
		if not obj2 then obj2 = base.root end
    if ( obj1 == nil ) then
        return false
    end
    if ( obj2 == nil ) then
        return false
    end		 
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    return ( left or right ) and ( up or down )
	end	
	function base.hasCollidedCircle( obj1, obj2 )
	  if ( obj1 == nil ) then
	      return false
	  end
	  if ( obj2 == nil ) then
	      return false
	  end
	  local dx = obj1.x - obj2.x
	  local dy = obj1.y - obj2.y

	  local distance = math.sqrt( dx*dx + dy*dy )
	  local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)

	  if ( distance < objectSize ) then
	      return true
	  end
	  return false
	end
	function base.imageSheet(actorPath, options)
		return graphics.newImageSheet( actorPath, options)
	end
	base.options = options or {}
	base.root = display.newGroup()
	base.reset()
	if base.group then
		base.group:insert(base.root)
	end
	base.manager = appStatus.manager
	base.tagName = tostring(base.root) .. base.root._role
	return base
end

return generate