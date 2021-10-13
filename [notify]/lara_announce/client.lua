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

--ID Command
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

--OOC Command
RegisterCommand('ooc', function(source, args)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local argString = table.concat(args, " ")
  
	if closestPlayer ~= -1 and closestDistance <= 10.0 then
		TriggerServerEvent('OOC', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), argString)
	else
		TriggerEvent("grv_notify", "#ab0503", "INFORMATION", "Keine Spieler in der Nähe")
	end
end)