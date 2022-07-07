-- dockeyLike.lua

local composer = require('composer')
local physics = require('physics')
local const = require('libs.constants')

local scene = composer.newScene( )

local reibaishi
local enemies = {}
local actors = {}
local items = {}
local keyState = {
	up = false,
	down = false,
	left = false,
	right = false,
}

math.randomseed(os.time())

-- UTILITIES
local function createSprite(object, imagePath, sheetPath, sequencePath)
	local imageSheet = graphics.newImageSheet( imagePath, require(sheetPath).sheetData )
	return display.newSprite( object.go, imageSheet, require(sequencePath) )
end

-- BASE
local function createBase(parent, options)
	local base = {}
	local baseGroup = display.newGroup( )
	parent:insert(baseGroup)
	baseGroup.x, baseGroup.y = options.x, options.y
	base.go = baseGroup
	base.options = options
	base.isPlayer = options.isPlayer
	return base
end

-- ACTOR
local function createActor(parent, options)
	local base = createBase(parent, options)
	local imagePath = 'assets/images/' .. options.name ..'/actor.png'
	local sheetPath = 'assets.images.' .. options.name ..'.actor'
	local sequencePath = 'assets.images.' .. options.name ..'.sequence'

	base.sprite = createSprite(base, imagePath, sheetPath, sequencePath)
	actors[#actors + 1] = base
	if options.isPlayer then
		player = base
	end

	function base.play(name)
		if base.sprite.sequence == name and base.sprite.isPlaying then return end
		base.sprite:setSequence(name)
		base.sprite:play()
	end

	function base.enterFrame()
	end

	function base.run()
		if base.isPlayer then
			if keyState.up then
				base.up()
			elseif keyState.down then
				base.down()
			end
			if keyState.left then
				base.left()
			elseif keyState.right then
				base.right()
			else
				base.wait()
			end
		else
			-- PC
		end
		base.enterFrame()
	end

	function base.up()
	end

	function base.down()
	end
	
	function base.left()
	end
	
	function base.right()
	end

	function base.wait()
	end

	-- PHYSICS DEFINITIONS
	physics.addBody(base.go, 'dynamic',
		{friction=1, density=0},
		{box={halfWidth=6, halfHeight=5, x=0, y=12}, isSensor=true},
		{box={halfWidth=6, halfHeight=5, x=0, y=-12}, isSensor=true})
		base.go.isFixedRotation = true
		base.go.sensorOverlaps = 0
		base.go.ladderOverlaped = 0
		base.go.collision = function(self, event)
		if event.selfElement == 2 and event.other.objType == 'ground' then
			-- ON FLOOR SENSOR
			if event.phase == 'began' then
					self.sensorOverlaps = self.sensorOverlaps + 1
			elseif event.phase == 'ended' then
					self.sensorOverlaps = self.sensorOverlaps - 1
			end
		elseif event.selfElement == 3 and event.other.objType == 'ladder' then
			-- ON LADDER SENSOR
			if event.phase == 'began' then
				self.ladderOverlaped = self.ladderOverlaped + 1
				base.go.gravityScale = 0
				self:setLinearVelocity( 0, 0 )
			elseif event.phase == 'ended' then
				self.ladderOverlaped = self.ladderOverlaped - 1
				base.go.gravityScale = 2
			end
		end
		if self.sensorOverlaps > 0 then
			base.go.linearDamping = 5
		else
			base.go.linearDamping = 0
		end
	end
	base.go:addEventListener( 'collision' )
	base.go.gravityScale = 2
	return base
end

-- Reibaishi
local function createReibaishi(parent, options)
	local options = options or {}
	options.name = 'reibaishi'
	local actor = createActor(parent, options)
	
	function actor.enterFrame()
	end

	function actor.up()
		if actor.go.ladderOverlaped > 0 then
			actor.go:translate(0, -2)
			actor.play("up")
		elseif actor.go.sensorOverlaps > 0 then
			local vx, vy = actor.go:getLinearVelocity( )
			actor.go:setLinearVelocity( vx, 0 )
			actor.go:applyLinearImpulse( nil, -0.06, actor.go.x, actor.go.y )
		end
	end

	function actor.down()
		if actor.go.ladderOverlaped > 0 then
			actor.go:translate(0, 2)
			actor.play("down")
		end
	end
	
	function actor.left()
		-- actor.go:setLinearVelocity( -50, 0 )
		actor.go:translate(-2, 0)
		-- actor.go:applyForce( -0.024, nil, actor.go.x, actor.go.y )
		-- actor.go:applyLinearImpulse( -0.005, nil, actor.go.x, actor.go.y )
		actor.play("left")
	end
	
	function actor.right()
		-- actor.go:setLinearVelocity( 50, 0 )
		actor.go:translate(2, 0)
		-- actor.go:applyForce( 0.024, nil, actor.go.x, actor.go.y )
		-- actor.go:applyLinearImpulse( 0.005, nil, actor.go.x, actor.go.y )
		actor.play("right")
	end

	function actor.wait()
		actor.play("lose")
	end
end

-- Objects
local function createLadder(parent, x, y)
	local width = 24
	local height = 65
	local margin = 5
	local number = 5
	local handHeight = (height - margin) / number
	local rectHeight = 3
	local ladderGroup = display.newGroup( )
	parent:insert(ladderGroup)
	ladderGroup.x, ladderGroup.y = x, y
	for i = 1, number do
		local rect = display.newRect(ladderGroup, 0, 0 + (i - 1) * handHeight + margin - height / 2 + rectHeight, width, rectHeight)
		rect:setFillColor( 1, 1, 1 )
	end
	physics.addBody( ladderGroup, 'static', {box={halfWidth=1, halfHeight=height / 2}, isSensor=true} )
	ladderGroup.objType = 'ladder'
	return ladderGroup
end

-- WATER
local function createWater(parent, x, y)
	local imagePath = 'assets/images/water/actor.png'
	local sheetPath = 'assets.images.water.actor'
	local sequencePath = 'assets.images.water.sequence'
	local number = 10
	local waterHeight = 16
	local startPoxY = (-16 * number / 2) + waterHeight / 2

	local waterGroup = display.newGroup()
	parent:insert(waterGroup)
	waterGroup.x, waterGroup.y = x, y
	for i = 0, number -1 do
		local waterSprite = createSprite({go=waterGroup}, imagePath, sheetPath, sequencePath)
		waterSprite.y = waterHeight * i + startPoxY
		waterSprite:play()
	end
	physics.addBody( waterGroup, 'dynamic', {isSensor=true} )

	waterGroup.objType = 'water'
	local timerid = timer.performWithDelay( 3000, function(event)
		waterGroup.y = const.soy - 160
		waterGroup:setLinearVelocity( 0, 0 )

		local aWidthHalf = (const.actualWidth - 32)  / 2

		waterGroup.x = math.random( -aWidthHalf, aWidthHalf )
	end, 0 )
	return waterGroup
end

-- PLATFORMS
local function createBasicPratform(parent, x, y, width, height, rotation, options )
	local timerid
	local function reverse(self, value)
		if options.updown then
			self:setLinearVelocity(0, value)
		else
			self:setLinearVelocity(value, 0)
		end
		timerid = timer.performWithDelay(3000, function(event)
			value = value * -1
			reverse(self, value)
		end)
	end
	local platformGroup = display.newGroup( )
	parent:insert(platformGroup)
	local platform = display.newRect(platformGroup, 0, 0, width, height)
	platform:setFillColor( 1.0, 0, 0 )
	platformGroup.x, platformGroup.y = x, y
	if rotation then
		platformGroup.rotation = rotation
	end
	platformGroup.objType = 'ground'
	if options then
		physics.addBody( platformGroup, 'kinematic', {friction=1, density=1} )
		platformGroup.isFixedRotation = true
		reverse(platformGroup, 50)
		return platformGroup
	end
	physics.addBody( platformGroup, 'static', {} )
	return platformGroup
end

-- BACKGROUND
local function createBackground(parent)
	for row = 0, 32 do
		for col = 0, 32 do
			display.newImage(
				parent, 
				'assets/images/background/purpleblock.png', 
				const.sox + col * 32, 
				const.soy + row * 32)
		end
	end
end

-- LEVEL
local function createLevel(parent)
	createBackground(parent)

	createLadder(parent, const.cx + 100, const.height - 70)
	createBasicPratform(parent, const.cx, const.height, 300, 30, 6)
	createBasicPratform(parent, const.cx + 100 - 30, const.height - 60, 30, 30)
	createBasicPratform(parent, const.cx + 100 - 100, const.height - 80, 30, 30, -32)
	createBasicPratform(parent, const.cx + 100 - 160, const.height - 250, 30, 30, 0, {updown=true})
	createBasicPratform(parent, 100, const.cy, 30, 30, 0, {})

	createReibaishi(parent, {x=const.cx, y=const.cy, isPlayer=true})
	createWater(parent, const.cx, const.soy - 160)
end

local function enterFrame(event)
	for i = 1, #actors do
		actors[i].run()
	end
end

local function keyInput(event)
	if not player then return end
	if event.phase == 'down' then
		if event.keyName == 'up' then
			keyState.up = true
		elseif event.keyName == 'down' then
			keyState.down = true
		elseif event.keyName == 'left' then
			keyState.left = true
		elseif event.keyName == 'right' then
			keyState.right = true
		end
	elseif event.phase == 'up' then
		if event.keyName == 'up' then
			keyState.up = false
		elseif event.keyName == 'down' then
			keyState.down = false
		elseif event.keyName == 'left' then
			keyState.left = false
		elseif event.keyName == 'right' then
			keyState.right = false
		end
	end
end

local function startGame()
	Runtime:addEventListener( 'enterFrame', enterFrame )
	Runtime:addEventListener( 'key', keyInput )
end

local function stopGame()
	Runtime:removeEventListener( 'enterFrame', enterFrame )
	Runtime:removeEventListener( 'key', keyInput )
end


-- COMPOSER
function scene:create(event)
	physics.start( )
	-- physics.setDrawMode( 'hybrid' )
	local sceneGroup = self.view
	createLevel(sceneGroup)
end

function scene:show(event)
	local sceneGroup = self.view
	if event.phase == 'will' then
		startGame()
	elseif event.phase == 'did' then
	end
end

function scene:hide(event)
	if event.phase == 'will' then
		stopGame()
	elseif event.phase == 'did' then
	end
end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene
