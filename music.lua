local Marketplace = game:GetService("MarketplaceService")
local ContentProvider = game:GetService("ContentProvider")
local MUSIC_LIST = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/main/list.lua"))()

local ValidMusic = {}

local function IsValidSound(soundId)
	local success, info = pcall(function()
		return Marketplace:GetProductInfo(soundId)
	end)

	if not success or not info then
		return false
	end

	if info.AssetTypeId ~= Enum.AssetType.Audio.Value then
		return false
	end

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. soundId
	sound.Parent = workspace

	local loaded = false

	pcall(function()
		ContentProvider:PreloadAsync({sound})
		loaded = sound.IsLoaded
	end)

	sound:Destroy()

	return loaded
end

task.spawn(function()
	for name, soundId in pairs(MUSIC_LIST) do
		task.spawn(function()
			if IsValidSound(soundId) then
				ValidMusic[name] = soundId
			end
		end)
	end
end)

return ValidMusic
