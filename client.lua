
local playerPed = nil
local timeout = false
local rakeObj = nil
local rakeOffset = vector3(0.0, 0.0, -0.6)

Citizen.CreateThread(function()
	while (true) do
		Citizen.Wait(0)
		
		playerPed = PlayerPedId()

        if (not timeout and rakeObj and DoesEntityExist(rakeObj) and Vdist(GetEntityCoords(PlayerPedId()) + vector3(0.0, 0.0, -1.0), GetOffsetFromEntityInWorldCoords(rakeObj, rakeOffset)) < 0.25) then
            timeout = true

            local vel = GetEntitySpeedVector(playerPed, false)
            local forward, right, up, pos = GetEntityMatrix(playerPed)
            SetEntityCoords(playerPed, pos + up * 0.01)
            SetEntityVelocity(playerPed, vel * 10.0)

            SetPedCanRagdoll(playerPed, true)
            SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)

            Citizen.CreateThread(function()
                while (true) do
                    Citizen.Wait(0)

                    ResetPedRagdollTimer(playerPed)

                    -- jumping / moving
                    if (IsControlJustPressed(0, 22) or IsControlJustPressed(0, 32) or IsControlJustPressed(0, 33) or IsControlJustPressed(0, 34) or IsControlJustPressed(0, 35)) then
                        Citizen.Wait(2000)
                        timeout = false
                        break
                    end
                end
            end)

            local boneIndex1 = GetEntityBoneIndexByName(playerPed, "IK_R_Foot")
            local boneIndex2 = GetEntityBoneIndexByName(playerPed, "IK_L_Foot")

            ApplyForceToEntity(playerPed, 1, vector3(0.0, 1.0, 0.0), vector3(0.0, 0.0, 0.0), boneIndex1, true, true, true, false, true)
            ApplyForceToEntity(playerPed, 1, vector3(0.0, 1.0, 0.0), vector3(0.0, 0.0, 0.0), boneIndex2, true, true, true, false, true)

            
            if (rakeObj) then
                SetEntityNoCollisionEntity(playerPed, rakeObj, false)

                Citizen.CreateThread(function()
                    TriggerServerEvent("Rake:delete", NetworkGetNetworkIdFromEntity(rakeObj))

                    Citizen.Wait(2000)

                    if (DoesEntityExist(rakeObj)) then
                        DeleteEntity(rakeObj)
                    end
                end)
            end
        end
	end
end)

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(500)

        local pos = GetEntityCoords(playerPed) + vector3(0.0, 0.0, -1.0)
        local obj = GetClosestObjectOfType(pos, 10.0, Config.model, false)
        if (DoesEntityExist(obj)) then
            rakeObj = obj
        else
            rakeObj = nil
        end
    end
end)



RegisterNetEvent("Rake:spawn")
AddEventHandler("Rake:spawn", function()
    RequestModel(Config.model)
    while (not HasModelLoaded(Config.model)) do
        Citizen.Wait(0)
    end

    local forward, right, up, pos = GetEntityMatrix(PlayerPedId())
    local rake = CreateObjectNoOffset(Config.model, pos + forward, true, true, false)
    SetEntityRotation(rake, -90.0, 0.0, 0.0)
    FreezeEntityPosition(rake, false)
    ApplyForceToEntity(rake, 3, 0.0, 0.0, 0.001, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
end)



if (GetResourceState("es_extended") ~= "started") then
    exports("SpawnRake", function()
        TriggerEvent("Rake:spawn")
    end)
end
