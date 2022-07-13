local M = {}
local size = 32
local namePrefix = {
	'bule',
	'purple',
	'green',
	'rectBlue',
	'rectRed',
}
local nameFragments = {
	'_wait1',
	'_wait2',
	'_down1',
	'_down2',
	'_up1',
	'_up2',
	'_left1',
	'_left2',
	'_right1',
	'_right2',
	'_win1',
	'_win2',
	'_lose1',
	'_lose2',
	'_start1',
	'_start2',
	'_start3',
	'_start4',
	'_damage1',
	'_dead1',
}
local function createSheet()
	local sheetData = {}
	sheetData.sheetContentWidth = size * #namePrefix
	sheetData.sheetContentHeight = size * #nameFragments
	local frames = {}
	for i, prefix in ipairs(namePrefix) do
		for j, fragments in ipairs(nameFragments) do
			frames[#frames + 1] = {
				name=prefix..fragments,
				x=(i - 1) * size,
				y=(j - 1) * size,
				width=size,
				height=size,
				sourceX=(i - 1) * size,
				sourceY=(j - 1) * size,
				sourceWidth=size,
				sourceHeight=size,
			}
		end
	end
	sheetData.frames = frames
	return sheetData
end

local sheetData = createSheet()
M.sheetData = sheetData
return M