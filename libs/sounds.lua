-- sounds.lua
local M = {}
local bgmHandles = {}
local seHandles = {}
local sePlaying = {}

function M.addBGM(path)
	bgmHandles[path] = audio.loadStream( path )
end

function M.addSE(path)
	seHandles[path] = audio.loadSound( path )
end

function M.playBMG(handleKey, options)
	audio.play( bgmHandles[handleKey], options )
end

function M.rewindBGM(handleKey, options)
	if handleKey then
		audio.rewind(bgmHandles[handleKey])
	elseif options then
		audio.rewind(options)
	else
		audio.rewind()
	end
end

function M.playSE(handleKey, options)
	function getIndexSEPlaying()
		for i = 1 , #sePlaying do
			if sePlaying[i] == handleKey then
				return i
			end
		end
		return nil
	end
	local index = getIndexSEPlaying()
	if index then return end


	local newIndex = #sePlaying + 1
	sePlaying[newIndex] = handleKey
	local opt = options or {}
	if not opt.onComplete then
		opt.onComplete=function(event)
			if event.completed then
				table.remove( sePlaying, newIndex )
			end
		end
	end
	audio.play( seHandles[handleKey], opt )
end

function M.pause(channel)
	audio.pause( channel )
end

function M.stop(channel)
	if channel then
		audio.stop(channel)
	else
		audio.stop()
	end
end

function M.setVolume(value, options)
	audio.setVolume( volume, options )
end


function M.disposeAll()
	audio.stop()

	for _, key in ipairs(bgmHandles) do
		audio.dispose( bgmHandles[key] )
		bgmHandles[key] = nil
	end

	for _, key in ipairs(seHandles) do
		audio.dispose( seHandles[key] )
		seHandles[key] = nil
	end

end

return M