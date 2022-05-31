local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("vorp_hunting:giveReward")
AddEventHandler("vorp_hunting:giveReward", function(givenItem, money, gold, rolPoints, xp, givenAmount, entity, horse, skipfinal)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local itemsAvailable = true 
    local done = false


    if #givenItem ~= #givenAmount then

        print('Error: Please ensure givenItem and givenAmount have the same length in the items config.')

    elseif givenItem ~= nil then
        local formattedGivenItems = {}
        local total = 0

        -- Format items and set random quantities if set.
        -- Check if items can be added
        -- total up the quantity so it can be checked as a whole
        for k, v in pairs(givenItem) do
            local nmb = 0

            if givenAmount[k] > 0 then
                nmb = givenAmount[k]
            else
                nmb = math.random(Config.ItemQuantity.Min, Config.ItemQuantity.Max)
            end

            formattedGivenItems[k] = {
                nmb = nmb,
                item = v
            }

            total = total + nmb

            -- Check if there is enough to add, if not send message
            TriggerEvent("vorpCore:canCarryItem", tonumber(_source), v, nmb, function(canCarryItem)                
                if canCarryItem ~= true then
                    itemsAvailable = false              
                end
                done = true
            end)

            while done == false do
                Wait(500)
            end
        end

        if itemsAvailable == false then
            TriggerClientEvent("vorp:TipRight", _source, 'Inventory is too full to sell this animal', 4000)
            return
        end

        -- Check if there is enough room in inventory in general.
        local invAvailable = VorpInv.canCarryItems(_source, total)
        if invAvailable ~= true then
            TriggerClientEvent("vorp:TipRight", _source, 'Inventory is too full to sell this animal', 4000)
            return
        end

        -- Give items
        for k, v in pairs(formattedGivenItems) do
            VorpInv.addItem(_source, v.item, v.nmb) 
        end

        if money ~= 0 then
            Character.addCurrency(0, money)
        end

        if gold ~= 0 then
            Character.addCurrency(1, gold)
        end

        if rolPoints ~= 0 then
            Character.addCurrency(2, rolPoints)
        end

        if xp ~= 0 then
            Character.addXp(xp)
        end
        

        if skipfinal ~= true then
            TriggerClientEvent("vorp_hunting:finalizeReward", _source, entity, horse, money)
        end
    end
end)


RegisterServerEvent("vorp_hunting:getJob")
AddEventHandler("vorp_hunting:getJob", function(source)
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local job = Character.job -- character table

    TriggerClientEvent("vorp_hunting:findJob", _source, job)

end)
