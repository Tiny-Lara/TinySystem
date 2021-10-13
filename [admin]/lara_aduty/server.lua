local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj  end)

ESX.RegisterServerCallback("Tiny:getRankFromPlayer", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

function sendToDiscord(color, name, title, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. title .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = footer,
			  },
		  }
	  }  
	PerformHttpRequest('https://discord.com/api/webhooks/894532243752628254/aQ51u3e8RF_x75TBWlY8OpUzH1vtoBZYIC8FiEWr0dQA2H6T3CO92hL0dMkzSzHPMm2q', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('bringplayertome')
AddEventHandler('bringplayertome', function(target,x,y,z)
    TriggerClientEvent('teleport', target, x, y, z)
end)


RegisterServerEvent('reloadchar')
AddEventHandler('reloadchar', function(target)
    TriggerClientEvent('rw:setplayerinclouds', target)
    Wait(500)
    TriggerClientEvent('rw:endjoinsession', target)
end)

local ticketData = {}

RegisterServerEvent('rw:closeTicket')
AddEventHandler('rw:closeTicket', function(id)
    TriggerClientEvent('notifications', ticketData[id]["id"], "#029488", "Support", "Dein Ticket wurde geschlossen.")
    TriggerClientEvent('notifications', source, "#029488", "Support", "Du hast das Ticket geschlossen.")
    ticketData[id] = nil
end)

RegisterCommand("supportcancel", function(source, args)
    TriggerClientEvent('supportcancel', source, "#029488", "Support", "Du hast deine Tickets geschlossen.")
    for k, v in pairs(ticketData) do
        if k ~= nil then
            if ticketData[k]["id"] == source then
                ticketData[k] = nil
            end
        end
    end
end, false)

RegisterServerEvent('rw:loadSupportAPP')
AddEventHandler('rw:loadSupportAPP', function()
    for k, v in pairs(ticketData) do
        if k ~= nil then
            TriggerClientEvent('rw:addTicket', source, ticketData[k]["name"], ticketData[k]["id"], ticketData[k]["msg"], tostring(k))
        end
    end
end)

RegisterServerEvent('sendticket')
AddEventHandler('sendticket', function(msg)
    ticketData[math.random(100,999)] = {["msg"] = msg, ["name"] = GetPlayerName(source), ["id"] = source}
    TriggerClientEvent('notifications', -1, msg, GetPlayerName(source) .. " | ID: " .. source)
    TriggerClientEvent('rw:addTicket', -1, GetPlayerName(source), source, msg, "/")
end)

RegisterServerEvent('tc')
AddEventHandler('tc', function(msg)
    TriggerClientEvent('notifications', -1, msg, GetPlayerName(source) .. " | ID: " .. source)
end)


ESX.RegisterServerCallback('rw:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
end)

RegisterCommand("aduty", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "projektleitung" or xPlayer.getGroup() == "manager" or xPlayer.getGroup() == "headadmin" or xPlayer.getGroup() == "administrator" or xPlayer.getGroup() == "dev" or xPlayer.getGroup() == "moderator" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "guide" then
        TriggerClientEvent('toggleAduty', source)
    else
        TriggerClientEvent('notifications', source, "#029488", "TinySystem", "Du hast keine Rechte.")
    end
end, false)

ESX.RegisterServerCallback('lara_admin:login', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    local data = {
        group = xPlayer.getGroup(),
        name = xPlayer.getName()
    }
    cb(data)
end)

ESX.RegisterServerCallback("lara:showHealthbar", function(source, cb)
    local copsOnDuty = 0

    local Players = ESX.GetPlayers()

    for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        TriggerClientEvent('yallah', xPlayer.source)
    end
end)

ESX.RegisterServerCallback("lara_server:getPlayers", function(source, cb)
    local Players = ESX.GetPlayers()
    cb(Players)
end)

RegisterServerEvent('tc')
AddEventHandler('tc', function(msg)
    TriggerClientEvent('notifications', -1, msg, GetPlayerName(source) .. " | ID: " .. source)
end)

RegisterServerEvent('ticket')
AddEventHandler('ticket', function(msg)
    TriggerClientEvent('kek', "TICKET" .. GetPlayerName(source) .. " | ID: " .. source, "Grund: " .. msg)
end)

RegisterServerEvent('bringplayertome')
AddEventHandler('bringplayertome', function(target,x,y,z)
    TriggerClientEvent('teleport', target, x, y, z)
end)

ESX.RegisterServerCallback('rw:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
end)

RegisterCommand("revive", function(source, args)
    local id = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(source)
    local zPlayer = ESX.GetPlayerFromId(id)
    if xPlayer.getGroup() == "guide" 
    or xPlayer.getGroup() == "supporter" 
    or xPlayer.getGroup() == "moderator" 
    or xPlayer.getGroup() == "dev" 
    or xPlayer.getGroup() == "administrator" 
    or xPlayer.getGroup() == "headadmin" 
    or xPlayer.getGroup() == "manager" 
    or xPlayer.getGroup() == "projektleitung" 
    then

    if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
            TriggerClientEvent('deineelternsindgeschwister', tonumber(args[1]))
            revive("Name: `" .. GetPlayerName(xPlayer.source) .." [ID: " .. xPlayer.source .."]`\nGruppe: `" .. xPlayer.getGroup() .."`\nAktion: `Revive`\n\n\n **Diese Person hat sich selber wiederbelebt !**", 15158332)

		end
	else
        TriggerClientEvent('deineelternsindgeschwister', source)
        revive("Name: " .. GetPlayerName(xPlayer.source) .." [ID: " .. xPlayer.source .."]`\nGruppe: `" .. xPlayer.getGroup() .."`\nAktion: `Revive`\n\n\n **Diese Person hat sich selber wiederbelebt !**", 15158332)

	end
    end
end, false)

RegisterCommand("jobgeben", function(source, args)
    local id = tonumber(args[1])
    local jobname =  args[2]
    local jobgrade =  args[3]


    local xPlayer = ESX.GetPlayerFromId(source)
    local zPlayer = ESX.GetPlayerFromId(id)
    if xPlayer.getGroup() == "guide" 
    or xPlayer.getGroup() == "supporter" 
    or xPlayer.getGroup() == "moderator" 
    or xPlayer.getGroup() == "dev" 
    or xPlayer.getGroup() == "administrator" 
    or xPlayer.getGroup() == "headadmin" 
    or xPlayer.getGroup() == "manager" 
    or xPlayer.getGroup() == "projektleitung" 
    then

   
        if id == nil then 
           TriggerClientEvent('notifications', source, "#029488", "TinySystem", "Ungültige ID.")
        else 
            zPlayer.setJob(jobname, jobgrade)
            TriggerClientEvent('notifications', source, "#029488", "TinySystem", "Du hast " .. GetPlayerName(zPlayer.source) .. " den Job " .. jobname .. " gegeben [ Rang: " .. jobgrade)
        end
  
    end
end, false)

RegisterCommand("tc", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
 
        TriggerServerEvent('tc', args)
   
end, false)

function GetPlayerNeededIdentifiers(source)
	local ids = GetPlayerIdentifiers(source)
	for i,theIdentifier in ipairs(ids) do
		 if string.find(theIdentifier,"license:") or -1 > -1 then
			  license = theIdentifier
		 elseif string.find(theIdentifier,"steam:") or -1 > -1 then
			  steam = theIdentifier
		 elseif string.find(theIdentifier,"discord:") or -1 > -1 then
			  discord = theIdentifier
		 end
	end
	if not steam then
		 steam = "Not found"
	end
	if not discord then
		 discord = "Not found"
	end
	return license, steam, discord
end

function kek(message, color)
	local embed = {
		{
			["color"] = color,
			["title"] = "**TinySystem**",
			["description"] = message,
			["footer"]=  {
				["text"]= "Admin - ".. os.date("%d.%m.%y") .. " - " .. os.date("%X") .. " Uhr",
			},
		}
	}
    
	PerformHttpRequest('https://discord.com/api/webhooks/894532243752628254/aQ51u3e8RF_x75TBWlY8OpUzH1vtoBZYIC8FiEWr0dQA2H6T3CO92hL0dMkzSzHPMm2q', function(err, text, headers) end, 'POST', json.encode({username = 'Feedback-System', embeds = embed}), { ['Content-Type'] = 'application/json' })
end 

-- "Name: `Ali [ID: 4]`\nGruppe: `projektleitung`\nAktion: `Rückerstattung`\nItem: `bread`\nMenge: `22`\n\nErhaltene Person: `Max [ID: 3]`"

function rueckerstattung(message, color)
	local embed = {
        {
          
                ["title"] = "TinySystem - Log",
                ["description"] = message,
                ["color"] =  2097008,
                ["footer"] = {
                    ["text"] = "@TinySystem by TinyLara"
                },
                ["image"] = {
                    ["url"] = ""
                }
        }
	}
    
	PerformHttpRequest('https://discord.com/api/webhooks/894532243752628254/aQ51u3e8RF_x75TBWlY8OpUzH1vtoBZYIC8FiEWr0dQA2H6T3CO92hL0dMkzSzHPMm2q', function(err, text, headers) end, 'POST', json.encode({username = 'Legacylife | Admin', embeds = embed}), { ['Content-Type'] = 'application/json' })
end 

function revive(message, color)
	local embed = {
        {
          
                ["title"] = "TinySystem - Log",
                ["description"] = message,
                ["color"] =  color,
                ["footer"] = {
                    ["text"] = "@TinySystem by TinyLara"
                },
                ["image"] = {
                    ["url"] = ""
                }
        }
	}
    
	PerformHttpRequest('https://discord.com/api/webhooks/894532243752628254/aQ51u3e8RF_x75TBWlY8OpUzH1vtoBZYIC8FiEWr0dQA2H6T3CO92hL0dMkzSzHPMm2q', function(err, text, headers) end, 'POST', json.encode({username = 'Legacylife | Admin', embeds = embed}), { ['Content-Type'] = 'application/json' })
end 

RegisterCommand("itemgeben", function(source, args)
    local id = tonumber(args[1])
    local itemname = args[2]
    local amount = tonumber(args[3])


    local xPlayer = ESX.GetPlayerFromId(source)
    local zPlayer = ESX.GetPlayerFromId(id)
  
    if xPlayer.getGroup() == "guide" 
    or xPlayer.getGroup() == "supporter" 
    or xPlayer.getGroup() == "moderator" 
    or xPlayer.getGroup() == "dev" 
    or xPlayer.getGroup() == "administrator" 
    or xPlayer.getGroup() == "headadmin" 
    or xPlayer.getGroup() == "manager" 
    or xPlayer.getGroup() == "projektleitung"  
    then
        print(amount)
        TriggerClientEvent('esx:showNotification', zPlayer.source, "Du hast " ..amount.. "x " ..itemname.. "  bekommen von einem Admin.")
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Du hast " ..amount.. "x " ..itemname.. "  " .. GetPlayerName(zPlayer.source) .. " gegeben")

        zPlayer.addInventoryItem(itemname, amount)
        rueckerstattung("Name: `" .. GetPlayerName(xPlayer.source) .." [ID: " .. xPlayer.source .."]`\nGruppe: `" .. xPlayer.getGroup() .."`\nAktion: `Rückerstattung`\nItem: `" .. itemname .."`\nMenge: `".. amount .."`\n\nErhaltene Person: `" .. GetPlayerName(zPlayer.source) .." [ID: " .. zPlayer.source .."]`")
    else
        TriggerClientEvent('notifications', source, "#029488", "TinySystem", "Du hast keine Rechte!")
    end
end, false)

RegisterCommand("goback", function(source, args, rawCommand)	-- /goback will teleport you back where you was befor /goto
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
		local playerCoords = savedCoords[source]
	  	if xPlayer.getGroup() == "projektleitung" or xPlayer.getGroup() == "manager" or xPlayer.getGroup() == "headadmin" or xPlayer.getGroup() == "administrator" or xPlayer.getGroup() == "dev" or xPlayer.getGroup() == "moderator" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "guide" then
	    	if playerCoords then
	      		xPlayer.setCoords(playerCoords)
				TriggerClientEvent("chatMessage", xPlayer.source, _U('goback'))
	      		savedCoords[source] = nil
	    	else
	      		TriggerClientEvent("chatMessage", xPlayer.source, _U('goback_error'))
	    	end
	  	end
	end
end, false)

RegisterServerEvent("skadmin:svtoggleFastSprint")
AddEventHandler("skadmin:svtoggleFastSprint", function(id)
  TriggerClientEvent("skadmin:toggleFastSprint", id)
end)

RegisterServerEvent("skadmin:svtoggleFastSwim")
AddEventHandler("skadmin:svtoggleFastSwim", function(id)
  TriggerClientEvent("skadmin:toggleFastSwim", id)
end)

RegisterServerEvent("skadmin:svtoggleSuperJump")
AddEventHandler("skadmin:svtoggleSuperJump", function(id)
  TriggerClientEvent("skadmin:toggleSuperJump", id)
end)

RegisterServerEvent("skadmin:svtoggleNoRagDoll")
AddEventHandler("skadmin:svtoggleNoRagDoll", function(id)
  TriggerClientEvent("skadmin:toggleNoRagDoll", id)
end)