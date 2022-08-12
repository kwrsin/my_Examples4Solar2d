-- customize.constants.lua

-- category bits
local	cate_player = 1
local	cate_enemy = 2
local	cate_player_bullet = 4
local	cate_enemy_bullet = 8
local	cate_item = 16

return {
	-- contents
	cx = display.contentCenterX,
	cy = display.contentCenterY,
	width = display.contentWidth,
	height = display.contentHeight,
	actualWidth = display.actualContentWidth,
	actualHeight = display.actualContentHeight,
	sox = display.screenOriginX,
	soy = display.screenOriginY,

	-- tile data
	tilesetPath = "assets/levels/",
	imagePath = "assets/images/",
	imageDotPath = "assets.images.",
	layerType_tile = 'tilelayer',
	layerType_object = 'objectgroup',

	-- actor direction
	dir_up = "up",
	dir_down = "down",
	dir_left = "left",
	dir_right = "right",
	dir_none = nil,

	-- actor's role
	role_player = "player",
	role_enemy = "enemy",
	role_npc = "npc",
	role_item = "item",
	role_bullet = "bullet",

	-- collision groups
	gcol_player = {categoryBits=cate_player, maskBits=cate_enemy + cate_enemy_bullet + cate_item},
	gcol_enemy = {categoryBits=cate_enemy, maskBits=cate_player + cate_player_bullet + cate_item},
	gcol_player_bullet = {categoryBits=cate_player_bullet, maskBits=cate_enemy + cate_enemy_bullet},
	gcol_enemy_bullet = {categoryBits=cate_enemy_bullet, maskBits=cate_player + cate_player_bullet},
	gcol_item = {categoryBits=cate_item, maskBits=cate_enemy + cate_player},

	-- scenarios
	scenario_hello = 1,

	-- sound effects
	bgm = "assets/sounds/idling.mp3",
	walking = "assets/sounds/player_walking.wav",

}