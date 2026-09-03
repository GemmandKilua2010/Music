local MarketplaceService = game:GetService("MarketplaceService")
local MUSIC_LIST = loadstring(game:HttpGet("https://raw.githubusercontent.com/GemmandKilua2010/Music/main/list.lua"))()

local ValidMusic = {}

for name, id in pairs(MUSIC_LIST) do
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(
            tonumber(id),
            Enum.InfoType.Asset
        )
    end)

    if success and info then
        ValidMusic[name] = id
        print("FUNCIONOU:", name, id)
    end
end

return ValidMusic
