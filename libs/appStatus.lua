-- appStatus.lua
require = require
local appStatus = {}

appStatus.level_path = ''
function appStatus.setPath(path)
	appStatus.level_path = path
end

return appStatus