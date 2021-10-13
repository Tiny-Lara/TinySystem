ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'ae', "supporter", function(source, args, user)
    local xPlayers = ESX.GetPlayers()
    local argString = table.concat(args, " ")
    if argString ~= nil then
    for i=1, #xPlayers, 1 do    
    TriggerClientEvent('lara_notifyannounce:display', xPlayers[i], 'Administrative Nachricht', argString, 6000, false)
    end
end
end)

RegisterNetEvent('OOC')
AddEventHandler('OOC', function(player, closestPlayer, argString)
    TriggerClientEvent("notifications", player, "#18880c", "OOC (" .. GetPlayerName(player) .. ")", argString)
    TriggerClientEvent("notifications", closestPlayer, "#18880c", "OOC (" .. GetPlayerName(player) .. ")", argString)
end)