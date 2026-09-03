local Marketplace = game:GetService("MarketplaceService")
local ContentProvider = game:GetService("ContentProvider")

local MUSIC_LIST = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/main/list.lua"))()

local function ValidateAllAsync(musicList)
	local validated = {}
	local threads = 0
	local done = 0
	local finishedEvent = Instance.new("BindableEvent")

	for name, soundId in pairs(musicList) do
		threads += 1
		task.spawn(function()
			local ok, info = pcall(function()
				return Marketplace:GetProductInfo(soundId)
			end)

			if ok and info and info.AssetTypeId == Enum.AssetType.Audio.Value then
				local sound = Instance.new("Sound")
				sound.SoundId = "rbxassetid://" .. soundId
				sound.Parent = workspace

				local preloadOk = pcall(function()
					ContentProvider:PreloadAsync({sound})
				end)

				if preloadOk and sound.IsLoaded then
					validated[name] = soundId
				end
				sound:Destroy()
			end

			done += 1
			if done == threads then
				finishedEvent:Fire()
			end
		end)
	end

	if done < threads then
		finishedEvent.Event:Wait()
	end

	return validated
end

local validMusic = ValidateAllAsync(MUSIC_LIST)
return validMusic
