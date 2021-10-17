ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local lara_ticket = {}

RegisterServerEvent('lara:closeTicket')
AddEventHandler('lara:closeTicket', function(id)
    TriggerClientEvent(Config.notify, lara_ticket[id]["id"], Config.notifycolor, Config.headline, "Dein Ticket wurde geschlossen.")
    TriggerClientEvent(Config.notify, source, Config.notifycolor, Config.headline, "Du hast das Ticket geschlossen.")
    lara_ticket[id] = nil
end)

function revive2(message, color)
	local embed = {
        {
          
                ["title"] = "Ticketsystem - Revive",
                ["description"] = message,
                ["color"] =  029488,
                ["footer"] = {
                    ["text"] = "@Ticketsystem by TinyLara"
                },
                ["image"] = {
                    ["url"] = "https://cdn.discordapp.com/attachments/872419164386635787/878565161026347048/logo_legacy4-klein.png"
                }
        }
	}
    
	PerformHttpRequest('https://discord.com/api/webhooks/895985898183852052/q3X_dDzHgXVJ3NiplBuxoaiOjkAioILNbuSxFDR2ksPvia6KICrhBd7glTAJ5fz6ewUg', function(err, text, headers) end, 'POST', json.encode({username = 'Legacylife | Admin', embeds = embed}), { ['Content-Type'] = 'application/json' })
end 

function go(message, color)
	local embed = {
        {
          
                ["title"] = "Ticketsystem - GOTO",
                ["description"] = message,
                ["color"] =  029488,
                ["footer"] = {
                    ["text"] = "@Ticketsystem by TinyLara"
                },
                ["image"] = {
                    ["url"] = "https://cdn.discordapp.com/attachments/872419164386635787/878565161026347048/logo_legacy4-klein.png"
                }
        }
	}
    
	PerformHttpRequest('https://discord.com/api/webhooks/895985898183852052/q3X_dDzHgXVJ3NiplBuxoaiOjkAioILNbuSxFDR2ksPvia6KICrhBd7glTAJ5fz6ewUg', function(err, text, headers) end, 'POST', json.encode({username = 'Legacylife | Admin', embeds = embed}), { ['Content-Type'] = 'application/json' })
end 

function bring(message, color)
	local embed = {
        {
          
                ["title"] = "TinySystem - BRING",
                ["description"] = message,
                ["color"] =  029488,
                ["footer"] = {
                    ["text"] = "@Ticketsystem by TinyLara"
                },
                ["image"] = {
                    ["url"] = "https://cdn.discordapp.com/attachments/872419164386635787/878565161026347048/logo_legacy4-klein.png"
                }
        }
	}
    
	PerformHttpRequest('https://discord.com/api/webhooks/895985898183852052/q3X_dDzHgXVJ3NiplBuxoaiOjkAioILNbuSxFDR2ksPvia6KICrhBd7glTAJ5fz6ewUg', function(err, text, headers) end, 'POST', json.encode({username = 'Legacylife | Admin', embeds = embed}), { ['Content-Type'] = 'application/json' })
end 

RegisterServerEvent('lara:loadTickets')
AddEventHandler('lara:loadTickets', function()
    for k, v in pairs(lara_ticket) do
        if k ~= nil then
            TriggerClientEvent('lara:addTicket', source, lara_ticket[k]["name"], lara_ticket[k]["id"], lara_ticket[k]["msg"], tostring(k))
        end
    end
end)

RegisterServerEvent('sendticket')
AddEventHandler('sendticket', function(msg)
    lara_ticket[math.random(100,999)] = 
    {
        ["msg"] = msg, 
        ["name"] = GetPlayerName(source),
        ["id"] = source
    }
   

    TriggerClientEvent('lara:addTicket', -1, GetPlayerName(source), source, msg, "/")
end)

RegisterServerEvent('lara:revive')
AddEventHandler('lara:revive', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayer = ESX.GetPlayerFromId(id)
	local src = source
	local target = ESX.GetPlayerFromId(id)
	local player = ESX.GetPlayerFromId(src)

    TriggerClientEvent('aduty_revive', source)
end)

RegisterCommand(Config.Commands.erstellen, function(source, args)
    local msg = table.concat(args, ' ')
    print(msg)
    lara_ticket[math.random(100,999)] = 
    {
        ["msg"] = msg, 
        ["name"] = GetPlayerName(source),
        ["id"] = source
    }
   
   -- TriggerClientEvent("adminnotify", -1, "Ein Ticket wurde soeben von (    " .. GetPlayerName(source) .. " [ID: " .. source .." ]    ) erstellt !")
    TriggerClientEvent("ticketnotify", -1, GetPlayerName(source) .. " ID: " .. source, msg)



    TriggerClientEvent('lara:addTicket', -1, GetPlayerName(source), source, msg, "/")
    TriggerClientEvent(Config.notify, source, Config.notifycolor, Config.headline, Config.Messages.createmsg)
end, false) 

RegisterCommand(Config.Commands.schliessen, function(source, args)
    TriggerClientEvent(Config.notify, source, Config.notifycolor, Config.headline, Config.Messages.deletemsg)
    for k, v in pairs(lara_ticket) do
        if k ~= nil then
            if lara_ticket[k]["id"] == source then
                lara_ticket[k] = nil
            end
        end
    end
end, false)

ESX.RegisterServerCallback('check', function(source, cb)
    local sayfullah = ESX.GetPlayerFromId(source)
    cb(sayfullah.getGroup())
end)


RegisterServerEvent("lara:bring")
AddEventHandler("lara:bring", function(id)
        local src = source
		local target = ESX.GetPlayerFromId(id)
		local player = ESX.GetPlayerFromId(src)
	    TriggerClientEvent('lara:teleportUser', id, player.getCoords().x, player.getCoords().y, player.getCoords().z)
        TriggerClientEvent(Config.notify, src, Config.notifycolor, Config.headline, "Du hast " .. GetPlayerName(target.source) .. " zu dir teleportiert.")

        local zPlayer = ESX.GetPlayerFromId(id)
		local xPlayer = ESX.GetPlayerFromId(src)
        bring("Name: `" .. GetPlayerName(xPlayer.source) .." [ID: " .. xPlayer.source .."]`\nGruppe: `" .. xPlayer.getGroup() .."`\nAktion: `BRING`\n\n\n **Diese Person wurde zu ihm teleportiert: `" .. GetPlayerName(zPlayer.source) .." [ID: " .. zPlayer.source .."]`**", 66555444)
			
end)

RegisterServerEvent("lara:goto")
AddEventHandler("lara:goto", function(id)
    local src = source
	local target = ESX.GetPlayerFromId(id)
	TriggerClientEvent('lara:teleportUser', src, target.getCoords().x, target.getCoords().y, target.getCoords().z)
    TriggerClientEvent(Config.notify, src, Config.notifycolor, Config.headline, "Du hast dich zu " .. GetPlayerName(target.source) .. " teleportiert.")

    local zPlayer = ESX.GetPlayerFromId(id)
    local xPlayer = ESX.GetPlayerFromId(src)
    go("Name: `" .. GetPlayerName(xPlayer.source) .." [ID: " .. xPlayer.source .."]`\nGruppe: `" .. xPlayer.getGroup() .."`\nAktion: `GOTO`\n\n\n **Zu dieser Person hat er sich teleportiert: `" .. GetPlayerName(zPlayer.source) .." [ID: " .. zPlayer.source .."]`**", 66555444)
end)





