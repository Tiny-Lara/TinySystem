ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterCommand("id", function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
	ESX.ShowNotification("Deine ID: " ..GetPlayerServerId(PlayerId()).. " ")
end)

RegisterCommand("ids", function(source, args, rawCommand)
	local playerPed = GetPlayerPed(-1)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		ESX.ShowNotification("Spieler ID in deiner Nähe: " ..GetPlayerServerId(closestPlayer).. " ")
	else
		ESX.ShowNotification("Keine Spieler in deiner Nähe")
	end
end)

RegisterNetEvent('notifications')
AddEventHandler('notifications', function(color, title, message)
    SendNUIMessage({
        type = "custom",
        color = "#029488",
		title = title,
        message = message,
    })
    
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)

RegisterNetEvent("rw_notifyOOC")
AddEventHandler("rw_notifyOOC", function(title, description, theme, type, duration, target)
	if GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) == target then
        SendNUIMessage({
            type = "length",
            color = "#029488",
            title = title,
            message = description,
        })
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	end
end)
