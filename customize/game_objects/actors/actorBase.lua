-- actorBase.lua
local const = require('customize.constants')
local sounds = require('libs.sounds')
local baseGenerate = require('customize.game_objects.base')
local physics = require 'physics'

local function createAttack(actor, skill)
	local skillsGroup = display.newGroup()
	actor.root:insert(skillsGroup)
	local attack = {}
	attack.skills = {}

	function attack.fire()
		-- local levelGroup = actor.group
		if attack.count() <= 0 then return end
		local skill = attack.pop()
		if not skill then return end

		local weaponGenerate = require('customize.game_objects.weapons.' .. skill)
		weaponGenerate({group=actor.group, x=actor.root.x, y=actor.root.y}, actor)
	end
	function attack.push(skill)
		if not skill then return end
		attack.skills[#attack.skills + 1] = skill
	end
	function attack.pop()
		return table.remove(attack.skills, #attack.skills)
	end
	function attack.remove(skill, idx)
		-- local function index()
		-- 	for i, value in ipairs(attack.skills) do
		-- 		if value == skill then return i end
		-- 	end
		-- 	return 0
		-- end
		-- local idx = index()
		if type(idx) == 'number' and idx > 0 then
			return table.remove(attack.skills, idx)
		end
	end
	function attack.clear()
		for idx = 1, #attack.skills do
			table.remove(attack.skills, idx)
		end
	end
	function attack.count()
		return #attack.skills
	end
	attack.push(skill)

	return attack
end

local function generate(actorName, options)
	local base = baseGenerate(options)
	base.manager.setActor(base)
	local isOptions = require(const.imageDotPath .. actorName .. ".actor")
	local imageSheet = base.imageSheet(const.imagePath .. actorName .. "/actor.png", isOptions.sheetData)
	local sequenceName = actorName .. ".sequence"
	if options.sequenceName then
		sequenceName = options.sequenceName
	else
	end
	local sqOptions = require(const.imageDotPath .. sequenceName)
	local sprite = display.newSprite( base.root, imageSheet, sqOptions )
	base.sprite = sprite
	base.thinking = false
	physics.addBody(base.root, 'dynamic', {friction=0.6, bounce=0.2, density=3, radius=10})
	base.root.collision = function(self, event)
		if event.phase == 'began' then
			if event.other._role == const.role_npc then
				base.manager.runScenario( event.other._scenario_index )
			elseif event.other._role == const.role_enemy then

			elseif event.other._role == const.role_item then

			end
		end
	end
	base.sprite:addEventListener( "sprite", function(event)
		base.spriteListener(event)
	end)


	base.root._actor_name = actorName
	base.root._is_player = base.isPlayer
	base.root:addEventListener('collision', base.root)
	base.root.gravityScale = 0.0
	base.currentDirection = {x=0, y=0}

	function base.spriteListener(event)
	end

	function base.direction()
		if not base.currentDirection then return const.dir_none end
		if base.currentDirection.x * base.currentDirection.x > base.currentDirection.y * base.currentDirection.y then
			if base.currentDirection.x > 0 then
				return const.dir_right
			elseif base.currentDirection.x < 0 then
				return const.dir_left
			end
		elseif base.currentDirection.x * base.currentDirection.x < base.currentDirection.y * base.currentDirection.y then
			if base.currentDirection.y > 0 then
				return const.dir_down
			elseif base.currentDirection.y < 0 then
				return const.dir_up
			end
		end
		return const.dir_none
	end

	function base.play(name)
		if base.sprite.sequence == name and base.sprite.isPlaying then return end
		base.sprite:setSequence(name)
		base.sprite:play()
	end
	
	function base:enterFrame(event)
		if base.disabled then
			return
		end
		if not base.isPlayer and not base.thinking then
			base.thinking = true
			base.think()
		end
		-- dead, not ready, 
		base.update(event)

		-- move, attack
		if base.buttonStatus then
			local cur = base.buttonStatus.cur
			if cur then
				base.onPressedCur(cur)
				base.currentDirection = cur
			end
			local btnA = base.buttonStatus.btnA
			if btnA then
				base.onPressedBtnA(btnA)
			end
			local btnB = base.buttonStatus.btnB
			if btnB then
				base.onPressedBtnB(btnB)
			end
		else
			base.waiting()
		end
	end
	function base.move(deltaX, deltaY)
		sounds.playSE(const.walking)
		base.root:translate( deltaX, deltaY )
	end
	function base.moveByBoundary(deltaX, deltaY)
		sounds.playSE(const.walking)
		local spHalfHeight = base.sprite.height / 2
		local spHalfWidth = base.sprite.width / 2
		if deltaY < 0 then
			if base.root.y + deltaY <= base.manager.boundary.top + spHalfHeight then
				base.root.y = base.manager.boundary.top + spHalfHeight
			else
				base.root.y = base.root.y + deltaY
			end
		elseif deltaY > 0 then
			if base.root.y + deltaY >= base.manager.boundary.bottom - spHalfHeight then
				base.root.y = base.manager.boundary.bottom - spHalfHeight
			else
				base.root.y = base.root.y + deltaY
			end
		end
		if deltaX < 0 then
			if base.root.x + deltaX <= base.manager.boundary.left + spHalfWidth then
				base.root.x = base.manager.boundary.left + spHalfWidth
			else
				base.root.x = base.root.x + deltaX
			end
		elseif deltaX > 0 then
			if base.root.x + deltaX >= base.manager.boundary.right - spHalfWidth then
				base.root.x = base.manager.boundary.right - spHalfWidth
			else
				base.root.x = base.root.x + deltaX
			end
		end
	end

	-- virtual
	function base.update(event)
	end
	function base.think()
	end
	function base.onPressedCur(value)
	end
	function base.onPressedBtnA(value)
	end
	function base.onPressedBtnB(value)
	end
	function base.waiting()
	end
	if base.isPlayer then
		base.manager.setPlayer(base)
	else
		base.manager.addEnemy(base)
	end
	base.skills = createAttack(base, base.skill)
	return base
end

return generate