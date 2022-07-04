-- constants.lua
return {
	-- contents
	cx = display.contentCenterX,
	cy = display.contentCenterY,
	width = display.contentWidth,
	height = display.contentHeight,
	actualWidth = display.actualContentWidth,
	actualHeight = display.actualContentHeight,

	-- tile data
	tilesetPath = "assets/levels/",
	imagePath = "assets/images/",
	imageDotPath = "assets.images.",
	layerType_tile = 'tilelayer',
	layerType_object = 'objectlayer',

	-- actor's role
	role_player = "player",
	role_enemy = "enemy",
	role_npc = "npc",
	role_item = "item",

	-- scenarios
	scenario_hello = 1,

}