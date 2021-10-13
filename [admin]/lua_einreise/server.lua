ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local xPlayerz = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local steamname = GetPlayerName(_source)
        MySQL.Async.fetchAll('SELECT neu FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayerz.identifier}, function(result)
            if result[1] then
                local resultfrommysql = json.encode(result[1].neu)
                local resultfrommysql2 = result[1].neu
                if resultfrommysql2 == "1" then
                    for i=1, #xPlayers, 1 do
                        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                        if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "admin" then
                            TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "L.S.I.A.", "Neuer Spieler in der Einreise: " .. steamname .. " | ID: " .. source)
                        end
                    end
                    TriggerClientEvent("isneu", _source, true)
                elseif result[1].neu == "0" then
                    TriggerClientEvent("isneu", _source, false)
                end
            end
        end)
end)


RegisterCommand("einreise", function(source, args)
    local _source = source
    local einreiseID = table.concat(args, " ")
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(einreiseID)
	local dimension = Config.Teleports.standart.dimension

    if xPlayer.getGroup() == "moderator" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "administrator" or xPlayer.getGroup() == "TinyLara" or xPlayer.getGroup() == "projekleitung" or xPlayer.getGroup() == "manager" or xPlayer.getGroup() == "headadmin" then
        TriggerClientEvent('notifications', einreiseID, "#ff0000", "L.A.I.A.", "Die Einreisebehörde bestätigt dein Visum")
        TriggerClientEvent('notifications', _source, "#ff0000", "L.A.I.A.", "Du bestätigst ein Visum")
        TriggerClientEvent('flughafentp', zPlayer.source)
        TriggerClientEvent("isneu", einreiseID, false) -- er darf wieder herumlaufen
		TriggerServerEvent('lua_einreise:setDimension', dimension)
        MySQL.Sync.execute("UPDATE users SET neu = 0 WHERE identifier = @identifier", {
            ['@identifier'] = zPlayer.identifier
        })
    else
        TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "L.A.I.A.", "Keine Berechtigung")
    end
end)

RegisterCommand("onGuide", function(source, args, dimension)
    local xPlayer = ESX.GetPlayerFromId(source)            
    local targetSource = args[1]
    local xTarget = ESX.GetPlayerFromId(targetSource)
	local dimension = Config.Teleports.pr.dimension

     if xPlayer and istInDimension then    
        if xPlayer.getGroup() == "moderator" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "administrator" or xPlayer.getGroup() == "TinyLara" or xPlayer.getGroup() == "projekleitung" or xPlayer.getGroup() == "manager" or xPlayer.getGroup() == "headadmin" then
            if xTarget then
		TriggerClientEvent("rein:teleport", xTarget.source, Config.Position)
		TriggerClientEvent('notifications', xTarget.source, "#ff0000", "L.A.I.A.", "Du befindest dich nun im Einreiseamt")
		TriggerServerEvent('lua_einreise:setDimension', dimension)
            else
		TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "L.A.I.A.", "Ungültige ID")
            end
        else
		TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "L.A.I.A.", "Keine Berechtigung")
        end
    end
end, false)

RegisterCommand("offGuide", function(source, args, dimension)
    local xPlayer = ESX.GetPlayerFromId(source)            
    local targetSource = args[1]
    local xTarget = ESX.GetPlayerFromId(targetSource)
	local dimension = Config.Teleports.standart.dimension

    if xPlayer and istInDimension then    
        if xPlayer.getGroup() == "moderator" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "administrator" or xPlayer.getGroup() == "TinyLara" or xPlayer.getGroup() == "projekleitung" or xPlayer.getGroup() == "manager" or xPlayer.getGroup() == "headadmin" then
            if xTarget then
		TriggerClientEvent("rein:teleport", xTarget.source, Config.Position2)
		TriggerClientEvent('notifications', xTarget.source, "#ff0000", "L.A.I.A.", "Du hast das Einreiseamt verlassen")
		TriggerServerEvent('lua_einreise:setDimension', dimension)
            else
		TriggerClientEvent('notifications',xPlayer.source, "#ff0000", "L.A.I.A.", "Ungültige ID")
            end
        else
        TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "L.A.I.A.", "Keine Berechtigung")
        end
    end
end, false)

TriggerEvent('es:addCommand', 'stats', function(source, args, user)
        TriggerClientEvent("notifications", source, "#ff0000", "Du bist " .. user.getGroup())
end)

RegisterServerEvent('lua_einreise:setDimension')
AddEventHandler('lua_einreise:setDimension', function(dimension)
    SetPlayerRoutingBucket(source, dimension)
end)