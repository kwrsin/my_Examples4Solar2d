-- customize.constants.lua
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

	-- scenarios
	scenario_hello = 1,

	-- sound effects
	bgm = "assets/sounds/idling.mp3",
	walking = "assets/sounds/player_walking.wav",

}