local ContentProvider = game:GetService("ContentProvider")
local list = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/refs/heads/main/list.lua"))()

local ValidMusic = {}

local function FilterMusic()
    local sounds = {}
    local musicBySound = {}

    for name, id in pairs(list) do
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. tostring(id)

        table.insert(sounds, sound)
        musicBySound[sound] = {
            Name = name,
            Id = tostring(id)
        }
    end

    ContentProvider:PreloadAsync(sounds, function(contentId, status)
        if status == Enum.AssetFetchStatus.Success then
            for sound, data in pairs(musicBySound) do
                if sound.SoundId == contentId then
                    ValidMusic[data.Name] = data.Id
                    break
                end
            end
        end
    end)

    for _, sound in ipairs(sounds) do
        sound:Destroy()
    end
    
    return ValidMusic
end

return FilterMusic()
