local ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("giveBrick")
AddEventHandler("giveBrick", function()
    local src = source
    if inv == "ox_inventory" then
        exports.ox_inventory:AddItem(src, itemname, 1)
    else
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addInventoryItem(itemname, 1)
    end
end)

RegisterNetEvent("removeBrick")
AddEventHandler("removeBrick", function()
    local src = source
    if inv == "ox_inventory" then
        exports.ox_inventory:RemoveItem(src, itemname, 1)
    else
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeInventoryItem(itemname, 1)
    end
end)

if framework == "ESX" then
    ESX.RegisterUsableItem(itemname, function(source)
        TriggerClientEvent("placetopedal", source)
    end)
end

ESX.RegisterServerCallback('checkPlayerItem', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem(item).count

    if itemCount > 0 then
        cb(true)
    else
        cb(false)
    end
end)
