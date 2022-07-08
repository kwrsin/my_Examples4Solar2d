-- scenario_hello.lua
local appStatus = require('libs.appStatus')
local const = require('customize.constants')
local M = {}

M.sentences = {
	{
		data = 'あなたはだれ？\n「まっくろくろすけ」？これは紛れもなくのりこむたの仕業かもしれません。あの天然の事故を引き起こしたのは奴に違いない！！早く逮捕しなければ、次々と犠牲者が増えていきます。',
		name = '新人刑事',
		image_path = 'assets/images/standups/pinkhead.png',
		imageYpos = 230,
		duration = 100,
		color = nil,
		needPrompt = true,
		trigger = function()
			appStatus.manager.runScenario( const.scenario_hello, 2 )
		end
	},
	{
		data = '助けてください！！',
		name = '新人刑事',
		image_path = 'assets/images/standups/pinkhead.png',
		imageYpos = 230,
		duration = 100,
		color = nil,
		needPrompt = false,
		trigger = function()
			appStatus.ui.confirm(function(value)
				if value == 'no' then
					appStatus.manager.runScenario( const.scenario_hello, 3 )
				else
					appStatus.manager.runScenario( const.scenario_hello, 4 )
				end					
			end)
		end
	},
	{
		data = 'このドケチがぁ〜〜っっ！！',
		name = '新人刑事',
		image_path = 'assets/images/standups/pinkhead.png',
		imageYpos = 230,
		duration = 100,
		color = nil,
		needPrompt = false,
		trigger = function()
			appStatus.manager.ui_mode = false
			timer.performWithDelay( 1000, function(event)
				appStatus.dialogue.flush()
			end )
		end
	},
	{
		data = 'ありがとうございます。！',
		name = '新人刑事',
		image_path = 'assets/images/standups/pinkhead.png',
		imageYpos = 230,
		duration = 100,
		color = nil,
		needPrompt = true,
		trigger = function()
			appStatus.manager.runScenario( const.scenario_hello, 1 )
			-- manager.ui_mode = false
			-- timer.performWithDelay( 1000, function(event)
			-- 	appStatus.dialogue.flush()
			-- end )
		end
	},
}


return M