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

    ContentProvider:PreloadAsync(sounds)

    for _, sound in ipairs(sounds) do
        if sound.IsLoaded then
            local data = musicBySound[sound]
            if data then
                ValidMusic[data.Name] = data.Id
            end
        end
        sound:Destroy()
    end

    return ValidMusic
end

return FilterMusic()
