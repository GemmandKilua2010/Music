local ContentProvider = game:GetService("ContentProvider")
local list = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/refs/heads/main/list.lua"))()

local ValidMusic = {}

local function FilterMusic()
    local sounds = {}
    local musicBySound = {}
    local remaining = 0

    for name, id in pairs(list) do
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. tostring(id)
        table.insert(sounds, sound)
        musicBySound[sound] = {
            Name = name,
            Id = tostring(id)
        }
        remaining += 1
    end

    local finished = false

    ContentProvider:PreloadAsync(sounds, function(contentId, status)
        if status == Enum.AssetFetchStatus.Success then
            for sound, data in pairs(musicBySound) do
                if sound.SoundId == contentId then
                    ValidMusic[data.Name] = data.Id
                    break
                end
            end
        end

        remaining -= 1
        if remaining <= 0 then
            finished = true
        end
    end)

    while not finished do
        task.wait()
    end

    for _, sound in ipairs(sounds) do
        sound:Destroy()
    end

    return ValidMusic
end

return FilterMusic()
