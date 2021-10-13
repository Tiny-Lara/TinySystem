ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local dimensionData ={}

ESX.RegisterServerCallback("getPlayerDimension", function(source, cb, target)
	if dimensionData[target] ~= nil then
		cb(dimensionData[target])
	else
		cb(0)
	end
end)

RegisterNetEvent('changeDimension')
AddEventHandler('changeDimension', function(dimension)
	dimensionData[source] = dimension
end)

RegisterNetEvent('InsertPlayer')
AddEventHandler('InsertPlayer', function()
	dimensionData[source] = 0
end)