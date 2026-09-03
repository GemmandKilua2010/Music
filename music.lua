local MarketplaceService = game:GetService("MarketplaceService")
local MUSIC_LIST = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/main/list.lua"))()

local ValidMusic = {}
local Pending = 0

for name, id in pairs(MUSIC_LIST) do
    Pending += 1

    task.spawn(function()
        local success, info = pcall(function()
            return MarketplaceService:GetProductInfo(
                tonumber(id),
                Enum.InfoType.Asset
            )
        end)

        if success and info and info.AssetTypeId == 3 then
            ValidMusic[name] = id
            print("FUNCIONOU:", name, id)
        else
            print("IGNORADO:", name, id)
        end

        Pending -= 1
    end)
end

repeat
    task.wait()
until Pending == 0

return ValidMusic
