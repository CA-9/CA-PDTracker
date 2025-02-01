local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("car_tracker", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == Config.AllowedJob then
        TriggerClientEvent('pd_tracker:useTracker', source)
        Player.Functions.RemoveItem("car_tracker", 1)
    else
        TriggerClientEvent('QBCore:Notify', source, "ليس لديك صلاحية لاستخدام هذا!", "error")
    end
end)

RegisterNetEvent('pd_tracker:placeTracker', function(vehicleNetId)
    TriggerClientEvent('pd_tracker:placeTracker', -1, vehicleNetId)
end)