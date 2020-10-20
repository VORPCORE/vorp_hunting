local VORPCore = {}

Citizen.CreateThread(function()
    while not VORPCore do        
        TriggerEvent("getCore", function(core)
            VORPCore = core
        end)
        Citizen.Await(200)
    end
end)

RegisterNetEvent("vorp:SelectedCharacter") -- NPC loads after selecting character
AddEventHandler("vorp:SelectedCharacter", function(charid)
    startButchers()
end)

function startButchers() -- Loading Butchers Function
    for i,v in ipairs(Config.Butchers) do 
        -- Loading Model
        local hashModel = GetHashKey(v.npcmodel) 
        if IsModelValid(hashModel) then 
            RequestModel(hashModel)
            while not HasModelLoaded(hashModel) do                
                Wait(100)
            end
        else 
            print(v.npcmodel .. " is not valid") -- Concatenations
        end        
        -- Spawn Ped
        local x, y, z = table.unpack(v.coords)
        local npc = CreatePed(hashModel, x, y, z, v.heading, false, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
        SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        Wait(1000)
        FreezeEntityPosition(npc, true) -- NPC can't escape
        SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z) -- Blip Creation
        SetBlipSprite(blip, v.blip, true) -- Blip Texture
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.butchername) -- Name of Blip
    end
end

function drawTxt(text, x, y, fontscale, fontsize, r, g, b, alpha, textcentred, shadow) -- Text function
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextScale(fontscale, fontsize)
    SetTextColor(r, g, b, alpha)
    SetTextCentre(textcentred)
    if shadow then 
        SetTextDropshadow(1, 0, 0, 255)
    end
    SetTextFontForCurrentCommand(1)
    DisplayText(str, x, y)
end

function sellAnimal() -- Selling animal function
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) -- ISPEDHOLDING
    local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
    local model = GetEntityModel(holding)
    local pedtype = GetPedType(holding)
    if holding ~= false then -- Checking if you are holding an animal        
        if Config.Animals[model] ~= nil then -- Paying for animals
            local animal = Config.Animals[model]
            local givenItem = animal.givenItem
            local money = animal.money
            local gold = animal.gold
            local rolPoints = animal.rolPoints
            local xp = animal.xp               
            TriggerServerEvent("vorp_hunting:giveReward", givenItem, money, gold, rolPoints, xp) 
            TriggerEvent("vorp:TipRight", Config.Language.AnimalSold, 4000) -- Sold notification
            DeleteEntity(holding) 
            Citizen.InvokeNative(0x5E94EA09E7207C16, holding)
            DeletePed(holding)       
        else -- Paying for skins 
            local skinFound = false
            for k, v in pairs(Config.Animals) do 
                local givenItem = v.givenItem
                local money = v.money
                local gold = v.gold
                local rolPoints = v.rolPoints
                local xp = v.xp               
                if quality == v.perfect then -- Checking perfect quality                    
                    local multiplier = v.perfectQualityMultiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier)  
                    skinFound = true    
                elseif quality == v.good then -- Checking good quality                    
                    local multiplier = v.goodQualityMultiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier)  
                    skinFound = true 
                elseif quality == v.poor then -- Checking poor quality                    
                    local multiplier = v.poorQualityMultiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier) 
                    skinFound = true                 
                end
            end
            if not skinFound then 
                TriggerEvent("vorp:TipRight", Config.Language.NotInTheButcher, 4000) -- Notification when the animal isn't being sold in the butcher 
            else
                TriggerEvent("vorp:TipRight", Config.Language.AnimalSold, 4000) -- Sold notification
                DeleteEntity(holding) 
                Citizen.InvokeNative(0x5E94EA09E7207C16, holding)
                DeletePed(holding)
            end            
        end     
    else
        TriggerEvent("vorp:TipRight", Config.Language.NotHoldingAnimal, 4000) -- Notification when you don't have an animal to sell
    end
end

-- RegisterCommand("hunt", function(source, args, rawCommand)
--     startButchers()
-- end, false)

-- RegisterCommand("check", function(source, args, rawCommand)
--     local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) -- ISPEDHOLDING
--     local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
--     local model = GetEntityModel(holding)
--     local pedtype = GetPedType(holding)
--     print("holding: " .. tostring(holding))
--     print("quality: ".. tostring(quality))
--     print("model: ".. tostring(model))
--     print("pedtype: ".. tostring(pedtype))
--  -- local lang = GetCurrentLanguage() -- Get user language
--  -- print("lang: ".. tostring(lang))
-- end, false)

Citizen.CreateThread(function()
    while true do
        for i,v in ipairs(Config.Butchers) do
            local playerCoords = GetEntityCoords(PlayerPedId())           
            if Vdist(playerCoords, v.coords) <= v.radius then -- Checking distance between player and butcher
                drawTxt(v.pressToSell, 0.5, 0.9, 0.7, 0.7, 255, 255, 255, 255, true, true)
                if IsControlJustPressed(2, 0xD9D0E1C0) then                  
                    sellAnimal() -- Sell Function     
                    Citizen.Wait(200)           
                end
            end
        end   
        Citizen.Wait(1)
    end
end)