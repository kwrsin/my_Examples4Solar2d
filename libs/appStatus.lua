-- appStatus.lua
local appStatus = {}

appStatus.level_path = ''
appStatus.controller = nil
function appStatus.setPath(path)
	appStatus.level_path = path
end
function appStatus.setController(controller)
	appStatus.controller = controller
end
function appStatus.setDialogue(dialogue)
	appStatus.dialogue = dialogue
end

return appStatus