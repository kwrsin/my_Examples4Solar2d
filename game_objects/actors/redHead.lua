-- redHead.lua
local const require('libs.constants')
local actorGenerate = require('game_objects.actors.actorBase')
local function generate(group, options)
	local actorBase = actorGenerate(group, 'red_head', options)

	actorBase.play('lose')

end

return generate
