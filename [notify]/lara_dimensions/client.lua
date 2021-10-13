local dimension = 0

local playerDimensions = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    Wait(3000)
    TriggerServerEvent('InsertPlayer')
end)

RegisterNetEvent('updateDimensions')
AddEventHandler('updateDimensions', function(dimension2)
    dimension = dimension2
end)

Citizen.CreateThread(function()
    while true do
        Wait(6000)
        local players = GetActivePlayers()
		for i = 1, #players do

			local currentplayer = players[i]
            local ped = GetPlayerPed(currentplayer)
            if ped ~= PlayerPedId() then
                Wait(500)
                ESX.TriggerServerCallback('getPlayerDimension', function(dimension2)   
                    playerDimensions[currentplayer] = dimension2
                end, GetPlayerServerId(currentplayer))
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local players = GetActivePlayers()
		for i = 1, #players do

			local currentplayer = players[i]
            local ped = GetPlayerPed(currentplayer)
            if ped ~= PlayerPedId() then
                if playerDimensions[currentplayer] == nil then
                    playerDimensions[currentplayer] = 0
                end
                if playerDimensions[currentplayer] == dimension then
                    SetPlayerVisibleLocally(currentplayer, true)
                else
                    SetPlayerInvisibleLocally(currentplayer, true)
                    SetEntityCoords(ped, 0, 0, 0, 0, 0, 0, false)
                end
            end
        end
    end
end)

RegisterNetEvent('setDimension')
AddEventHandler('setDimension', function(dimension2)
    dimension = tonumber(dimension2)
    TriggerServerEvent('changeDimension', dimension)
    ESX.ShowNotification("Deine Dimension wurde gewechselt.")
end)