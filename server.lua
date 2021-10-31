
RegisterNetEvent("Rake:delete")
AddEventHandler("Rake:delete", function(netId)
	local rake = NetworkGetEntityFromNetworkId(netId)
	if (DoesEntityExist(rake) and GetEntityModel(rake) == Config.model) then
        if (Config.isDebug) then
            print("Deleting rake at " .. tostring(GetEntityCoords(rake)))
        end
        
        ApplyForceToEntity(rake, 1, vector3(0.0, -5.0, 0.0), vector3(0.0, 0.0, 0.6), 0, true, true, true, false, true)

        Citizen.Wait(2000)

        if (DoesEntityExist(rake)) then
		    DeleteEntity(rake)
        end
	end
end)



if (GetResourceState("es_extended") == "started") then
    local ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    ESX.RegisterUsableItem("rake", function(playerId)
        local playerData = ESX.GetPlayerFromId(playerId)
        playerData.removeInventoryItem("rake", 1)
        playerData.showNotification("You dropped a rake.")

        TriggerClientEvent("Rake:spawn", playerId)
    end)
end
