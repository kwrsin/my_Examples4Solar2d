-- appStatus.lua
require = require
local appStatus = {}

appStatus.level_path = ''
appStatus.controller = nil
function appStatus.setPath(path)
	appStatus.level_path = path
end
function appStatus.setController(controller)
	appStatus.controller = controller
end

return appStatus