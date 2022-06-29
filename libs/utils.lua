-- utils.lua
local utf8 = require( "plugin.utf8" )

local M = {}

function M.toArray(string)
	t = {}
	utf8.gsub(string, ".",function(c) table.insert(t, c) end)
	return t
end

function M.len(string)
	return utf8.len(string)
end

return M