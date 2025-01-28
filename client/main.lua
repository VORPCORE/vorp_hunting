---@diagnostic disable: undefined-global
local Core = exports.vorp_core:GetCore()
local peltz = {}
local prompts = GetRandomIntInRange(0, 0xffffff)
local openButcher
local pressed = false

RegisterNetEvent('vorp_hunting:finalizeReward', function(entity, horse)
    -- Remove Animal/Pelt
    if entity and DoesEntityExist(entity) then
        DeleteEntity(entity)
        Citizen.InvokeNative(0x5E94EA09E7207C16, entity) --Delete_2 Entity
    end
    -- Remove pelt from horse
    if horse and DoesEntityExist(horse.horse) then
        Citizen.InvokeNative(0x627F7F3A0C4C51FF, horse.horse, horse.pelt)
    end
end)

RegisterNetEvent("vorp_hunting:unlock", function()
    pressed = false
end)

function StartButchers() -- Loading Butchers Function
    for i, v in ipairs(Config.Butchers) do
        if v.butcherped then
            local hashModel = joaat(v.npcmodel)
            if IsModelValid(hashModel) then
                RequestModel(hashModel, false)
                while not HasModelLoaded(hashModel) do
                    Wait(100)
                end
            else
                return print(v.npcmodel .. " is not valid") -- Concatenations
            end
            -- Spawn Ped
            local npc = CreatePed(hashModel, v.coords.x, v.coords.y, v.coords.z, v.heading, false, false, false, false)
            repeat Wait(0) until DoesEntityExist(npc)
            Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
            PlaceEntityOnGroundProperly(npc, true)
            SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
            SetEntityCanBeDamaged(npc, false)
            SetEntityInvincible(npc, true)
            Wait(1000)
            FreezeEntityPosition(npc, true)            -- NPC can't escape
            SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
            Config.Butchers[i].NpcHandle = npc
        end
        if v.showblip then
            local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords) -- Blip Creation
            SetBlipSprite(blip, v.blip, true)                                           -- Blip Texture
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.butchername)               -- Name of Blip
            Config.Butchers[i].BlipHandle = blip
        end
    end
end

local function awardQuality(quality, entity, horse, cb)
    local skinFound = nil
    for k, v in pairs(Config.Animals) do
        if (quality == v.perfect) or (quality == v.good) or (quality == v.poor) then
            skinFound = k
            break -- no need to keep looping through the config; micro-optimizations ftw!
        end
    end

    if skinFound then
        TriggerServerEvent("vorp_hunting:giveReward", "pelt", {
            model = skinFound,
            quality = quality,
            entity = entity,
            horse = horse
        }, false)
        cb()
    end
end

local function SellAnimal()                                               -- Selling animal function
    local horse = Citizen.InvokeNative(0x4C8B59171957BCF7, PlayerPedId()) -- _GET_LAST_MOUNT
    local alreadysoldanimal = false
    -- Logic for if a horse is detected

    if horse and DoesEntityExist(horse) and NetworkGetEntityOwner(horse) == PlayerId() then
        -- Check if the horse is holding anything
        if Citizen.InvokeNative(0xA911EE21EDF69DAF, horse) then              -- IS_PED_CARRYING_SOMETHING
            local holding2 = Citizen.InvokeNative(0xD806CD2A4F2C2996, horse) -- _GET_FIRST_ENTITY_PED_IS_CARRYING
            local model2 = GetEntityModel(holding2)

            local quality2 = Citizen.InvokeNative(0x31FEF6A20F00B963, holding2) --_GET_CARRIABLE_FROM_ENTITY
            if Config.Animals[model2] then                                      -- Fallback for paying for non pelts
                alreadysoldanimal = true
                local netid = NetworkGetNetworkIdFromEntity(holding2)
                TriggerServerEvent("vorp_hunting:giveReward", "carcass",
                    { model = model2, entity = holding2, netid = netid }, false)
            elseif (quality2 ~= false and quality2 ~= nil) then --Award pelt if pelt is on horse
                awardQuality(quality2, holding2, nil, function()
                    alreadysoldanimal = true
                end)
            end
        end

        if Citizen.InvokeNative(0x0CEEB6F4780B1F2F, horse, 0) then -- _GET_PELT_FROM_HORSE
            for x = #peltz, 1, -1 do
                local y = peltz[x]
                if not y.sold then
                    y.sold = true
                    local q = Citizen.InvokeNative(0x0CEEB6F4780B1F2F, horse, x - 1)
                    awardQuality(q, nil, { horse = horse, pelt = q }, function()
                        alreadysoldanimal = true
                    end)
                end
                table.remove(peltz, x)
            end
        end
    end

    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) -- ISPEDHOLDING
    if holding and alreadysoldanimal == false then                          -- Checking if you are holding an animal
        local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)   -- _GET_CARRIABLE_FROM_ENTITY

        local model = GetEntityModel(holding)

        if holding then
            local entityNetworkId = NetworkGetNetworkIdFromEntity(holding)
            SetNetworkIdExistsOnAllMachines(entityNetworkId, true)
            local entityId = NetworkGetEntityFromNetworkId(entityNetworkId)

            if not NetworkHasControlOfEntity(entityId) then
                NetworkRequestControlOfEntity(entityId)
                NetworkRequestControlOfNetworkId(entityNetworkId)
            end
        end

        if Config.Animals[model] then -- Paying for animals
            alreadysoldanimal = true
            local netid = NetworkGetNetworkIdFromEntity(holding)
            return TriggerServerEvent("vorp_hunting:giveReward", "carcass",
                { model = model, entity = holding, netid = netid }, false)
        else -- Paying for skins
            awardQuality(quality, holding, nil, function()
                alreadysoldanimal = true
            end)
        end
    end

    if (alreadysoldanimal == false) then
        if holding == false then
            Core.NotifyObjective(Config.Language.NotHoldingAnimal, 4000)
        else
            Core.NotifyObjective(Config.Language.NotInTheButcher, 4000)
        end
    end

    SetTimeout(5000, function()
        pressed = false
    end)
end


AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for key, value in ipairs(Config.Butchers) do
        if value.NpcHandle then
            DeleteEntity(value.NpcHandle)
        end
        if value.BlipHandle then
            RemoveBlip(value.BlipHandle)
        end
    end
end)

CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession
    local str = Config.Language.press
    openButcher = PromptRegisterBegin()
    PromptSetControlAction(openButcher, Config.keys["G"])
    str = VarString(10, 'LITERAL_STRING', str)
    PromptSetText(openButcher, str)
    PromptSetEnabled(openButcher, 1)
    PromptSetVisible(openButcher, 1)
    PromptSetStandardMode(openButcher, 1)
    PromptSetHoldMode(openButcher, 1)
    PromptSetGroup(openButcher, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, openButcher, true)
    PromptRegisterEnd(openButcher)
end)

CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession

    Citizen.InvokeNative(0x39363DFD04E91496, PlayerId(), true) -- enable mercy kil
    while true do
        local sleep = 1000
        local player = PlayerPedId()
        local horse = Citizen.InvokeNative(0x4C8B59171957BCF7, player)
        if horse ~= nil then
            local playerCoords = GetEntityCoords(player)
            local horsecoords = GetEntityCoords(horse)
            local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, player)
            local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
            local dist = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, horsecoords.x,
                horsecoords.y, horsecoords.z, false)

            if 2 > dist then
                local model = GetEntityModel(holding)
                if holding ~= false and Config.Animals[model] == nil then
                    local maxpelts = 3 -- cant bemore than this
                    if maxpelts > #peltz then
                        sleep = 0
                        local label = CreateVarString(10, 'LITERAL_STRING', Config.Language.stow)
                        PromptSetActiveGroupThisFrame(prompts, label)

                        if Citizen.InvokeNative(0xC92AC953F0A982AE, openButcher) then
                            TaskPlaceCarriedEntityOnMount(player, holding, horse, 1)
                            table.insert(peltz, {
                                holding = holding,
                                quality = quality
                            })

                            Wait(500)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

--  Check for Animals being skinned/plucked/stored
CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession

    while true do
        Wait(0)
        local size = GetNumberOfEvents(0)
        if size > 0 then
            for index = 0, size - 1 do
                local event = GetEventAtIndex(0, index)
                if event == `EVENT_LOOT_COMPLETE` then
                    local eventDataSize = 3
                    local eventDataStruct = DataView.ArrayBuffer(24)
                    eventDataStruct:SetInt32(0, 0)
                    eventDataStruct:SetInt32(8, 0)
                    eventDataStruct:SetInt32(16, 0)
                    local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA, 0, index, eventDataStruct:Buffer(),
                        eventDataSize)
                    if is_data_exists then
                        if PlayerPedId() == eventDataStruct:GetInt32(0) then
                            local pedid = eventDataStruct:GetInt32(8)
                            if eventDataStruct:GetInt32(16) == 1 then
                                local model = GetEntityModel(pedid)
                                if model and Config.SkinnableAnimals[model] then
                                    if Config.SkinnableAnimals[model].deletePelt then
                                        Wait(1000)
                                        local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                                        local isPelt = GetIsCarriablePelt(holding) == 1
                                        local isAnimal = GetIsAnimal(holding) == 1

                                        if isPelt and not isAnimal then
                                            SetEntityAsMissionEntity(holding, true, true)
                                            SetEntityAsNoLongerNeeded(holding)

                                            DeleteEntity(holding)
                                        end
                                    end
                                    TriggerServerEvent("vorp_hunting:giveReward", "skinned", { model = model }, true)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    if not Config.butcherfunction then
        return
    end

    if Config.DevMode or Config.butcherfunction then
        StartButchers()
    end

    while true do
        local sleep = 1000
        for i, v in ipairs(Config.Butchers) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - v.coords)

            if distance <= v.radius then
                sleep = 0
                local label = CreateVarString(10, 'LITERAL_STRING', Config.Language.sell)
                PromptSetActiveGroupThisFrame(prompts, label)

                if Citizen.InvokeNative(0xC92AC953F0A982AE, openButcher) then
                    if not pressed then
                        pressed = true
                        if Config.joblocked then
                            local result = Core.Callback.TriggerAwait("vorp_hunting:GetPlayerJob", args)
                            local playerJob = result
                            if playerJob == v.butcherjob then
                                SellAnimal()
                            else
                                Core.NotifyObjective(Config.Language.notabutcher .. " : " .. v.butcherjob, 4000)
                            end
                        else
                            SellAnimal()
                        end
                    end
                end
            end
        end

        Wait(sleep)
    end
end)


-----  useful to get hash from animals or pelts  ------------
if Config.DevMode then
    RegisterCommand('animal', function(source, args, rawCommand)
        local ped = PlayerPedId()
        local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
        local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
        local model = GetEntityModel(holding)
        local type = GetPedType(holding)
        local hash = joaat(holding)

        print('holding', holding)
        print('quality', quality)
        print('model', model)
        print('type', type)
        print('hash', hash)
    end, false)
    --

    ----------- spawn an animal to make tests ------------------

    RegisterCommand("hunt", function(source, args, rawCommand)
        local animal = args[1]
        local freeze = args[2]
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)

        if animal == nil then
            animal = 'a_c_goat_01'
        end

        if freeze == nil then
            freeze = '2000'
        end

        freeze = tonumber(freeze)


        RequestModel(animal, false)
        while not HasModelLoaded(animal) do
            Wait(10)
        end

        animal = CreatePed(animal, playerCoords.x, playerCoords.y, playerCoords.z, 0.0, true, false, false, false)
        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, animal, 1, 0)
        Wait(freeze)
        FreezeEntityPosition(animal, true)
    end, false)
end
