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
function appStatus.setUI( ui )
	appStatus.ui = ui
end
function appStatus.setManager(manager)
	appStatus.manager = manager
	if appStatus.controller then
		appStatus.manager.controller = appStatus.controller
	end
end


return appStatus