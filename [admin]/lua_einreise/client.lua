local isneu = false
local istInDimension = false
local notify = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("isneu") 
AddEventHandler("isneu", function(neu)
    isneu = neu
end)

RegisterNetEvent("flughafentp") 
AddEventHandler("flughafentp", function(einreiseID)
	if istInDimension then
    Citizen.CreateThread(function (dimension)
    local dimension = Config.Teleports.standart.dimension
    local ped = PlayerPedId()
    local currentPos = GetEntityCoords(ped)
    SetEntityCoords(ped, -1071.6, -2742.91, 21.31, false, false, false, true)
	
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isneu then
            local ped = PlayerPedId()
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.EinreiseX, Config.EinreiseY, Config.EinreiseZ, true) < 250 then
                else
                    SetEntityCoords(ped, Config.EinreiseX, Config.EinreiseY, Config.EinreiseZ, false, false, false, true)
            end
        end
    end
end)


RegisterNetEvent("rein:teleport")
AddEventHandler("rein:teleport", function(coords)
    local x, y, z = table.unpack(coords)
	local dimension = Config.Teleports.pr.dimension
    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, true)
end)

Citizen.CreateThread(function()
  SetDeepOceanScaler(0.0)
end)