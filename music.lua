local Marketplace = game:GetService("MarketplaceService")
local ContentProvider = game:GetService("ContentProvider")

local MUSIC_LIST = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/main/list.lua"))()

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

for name, soundId in pairs(MUSIC_LIST) do
	if not IsValidSound(soundId) then
		MUSIC_LIST[name] = nil
	end
end

return MUSIC_LIST
