-- appStorage.lua
require = require
local storage = {}

storage.level_path = ''
function storage.setPath(path)
	storage.level_path = path
end

return storage