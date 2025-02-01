local QBCore = exports['qb-core']:GetCoreObject()
local trackerActive = false
local blip = nil
local vehicleNetId = nil

RegisterNetEvent('pd_tracker:useTracker', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then
        TriggerServerEvent('pd_tracker:placeTracker', VehToNet(vehicle))
    else
        QBCore.Functions.Notify("لم يتم العثور على المركبة!", "error")
    end
end)

RegisterNetEvent('pd_tracker:placeTracker', function(vehicleNetId)
    if trackerActive then
        QBCore.Functions.Notify("هناك جهاز تعقب بالفعل قيد التشغيل!", "error")
        return
    end

    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if not DoesEntityExist(vehicle) then
        QBCore.Functions.Notify("المركبة غير متوفرة!", "error")
        return
    end

    trackerActive = true

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do Wait(10) end

    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.0, 1.0, 5000, 49, 0, false, false, false)
    Wait(5000)

    blip = AddBlipForEntity(vehicle)
    SetBlipSprite(blip, Config.TrackerBlip)
    SetBlipColour(blip, Config.TrackerColour)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("مركبة متعقبة")
    EndTextCommandSetBlipName(blip)

    Citizen.CreateThread(function()
        while trackerActive do
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if DoesEntityExist(vehicle) then
                local coords = GetEntityCoords(vehicle)
                SetBlipCoords(blip, coords.x, coords.y, coords.z)
end
            Wait(1000)
        end
    end)

    SetTimeout(300000, function()
        trackerActive = false
        if DoesBlipExist(blip) then RemoveBlip(blip) end
        QBCore.Functions.Notify("تم تعطيل جهاز التعقب!", "error")
    end)
end)