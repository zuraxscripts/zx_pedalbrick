local ESX = exports["es_extended"]:getSharedObject()

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

RegisterNetEvent("pickupBrick")
AddEventHandler("pickupBrick", function()
    loadAnimDict("pickup_object")
    TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 1.0, -1.0, -1, 2, 1, true, true, true)
    Wait(2000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent("giveBrick")
end)
 
exports['ox_target']:addModel(brick, {
    {
        name = "brick1",
        debugPoly = false,
        useZ = true,
        event = "pickupBrick",
        icon = "fa fa-signing",
        label = Language.pickup,
        distance = 2.5
    }
})

exports.ox_target:addGlobalVehicle({
    {
        label = Language.plasserpedal,
        name = 'brick',
        icon = 'fa fa-signing',
        item = itemname,
        bones = "door_dside_f",
        distance = 2.5,
        onSelect = function(data)
            local entity = data.entity
            if not DoesEntityExist(entity) then return end
            
            ESX.TriggerServerCallback('checkPlayerItem', function(hasItem)
                if hasItem then
                    TriggerEvent("placetopedal")
                else
                    ESX.ShowNotification(Language.noitem)
                end
            end, itemname)
        end
    }
})

RegisterNetEvent("placetopedal")
AddEventHandler("placetopedal", function()
    local coords = GetEntityCoords(PlayerPedId())
    local vehicle = ESX.Game.GetClosestVehicle(coords)
    if not DoesEntityExist(vehicle) then
        ESX.ShowNotification(Language.close)
        return
    end

    local vehcoords = GetEntityCoords(vehicle)
    local distance = GetDistanceBetweenCoords(coords, vehcoords, true)
    local door = GetVehicleDoorLockStatus(vehicle)

    if door == 2 then
        ESX.ShowNotification(Language.locked)
        return
    end

    if distance < 2.5 then
        SetVehicleDoorOpen(vehicle, 0, false, true)
        loadAnimDict("pickup_object")
        TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 1.0, -1.0, -1, 2, 1, true, true, true)
        Wait(2000)
        TriggerServerEvent("removeBrick")
        ClearPedTasks(PlayerPedId())
        SetVehicleDoorShut(vehicle, 0, false)
        SetVehicleEngineOn(vehicle, true, true, false)
        Wait(1000)
        ESX.ShowNotification(Language.placedonpedal)

        -- Auto sa začne pohybovať dopredu
        TaskVehicleTempAction(PlayerPedId(), vehicle, 32, time)  -- 32 = Drive forward, time = čas v ms

        if Config.breakcar then
            CreateThread(function()
                while true do
                    Wait(10)
                    if HasEntityCollidedWithAnything(vehicle) then
                        SetVehicleEngineOn(vehicle, false, false, false)
                        SetVehicleEngineHealth(vehicle, 0)
                        SetVehicleUndriveable(vehicle, true)
                        break
                    elseif loopabreaka then
                        break
                    end
                end
            end)
        end

        if breakcar then
            Wait(15000)
            loopabreaka = true
        end
    else
        ESX.ShowNotification(Language.close)
    end
end)

