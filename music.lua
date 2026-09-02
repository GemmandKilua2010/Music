local ContentProvider = game:GetService("ContentProvider")
local MarketplaceService = game:GetService("MarketplaceService")
local list = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/refs/heads/main/list.lua"))()

local ValidMusic = {}

local function IsValidAudio(id)
    id = tonumber(id)
    if not id then return false end

    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(id)
    end)

    if not success or not info or info.AssetTypeId ~= 3 then
        return false
    end

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id

    local loaded = false
    local connection
    connection = sound.Loaded:Connect(function()
        loaded = true
    end)

    ContentProvider:PreloadAsync({sound})

    task.wait(0.3)

    local isReallyValid = loaded and sound.IsLoaded and sound.TimeLength > 1

    connection:Disconnect()
    sound:Destroy()

    return isReallyValid
end

local function FilterMusic()
    for name, id in pairs(list) do
        if IsValidAudio(id) then
            ValidMusic[name] = tostring(id)
        end
    end
    return ValidMusic
end

return FilterMusic()
