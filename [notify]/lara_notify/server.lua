RegisterServerEvent("rw_notify:OOC")
AddEventHandler("rw_notify:OOC", function(message, target, sender)
	TriggelaraientEvent("rw_notifyOOC", -1, "OOC (" .. sender .. ")", message, "dark", "info", (string.len(message) * 100 * 1.2) + 1000, target)
end)

ESX               = nil

function sendEventLog(color, name, title, message, footer)
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
	--PerformHttpRequest('https://discord.com/api/webhooks/778567574270115851/4qvVt2j8d6hAb_fe24_eX1sxA9nIa0Vd1e11uhZHJWBDQHwrAIWHe5UmaLlN6AgnrTmb', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function GetPlayerIdentiferString(source)
	local a, b, c, d, e, f, g = table.unpack(GetPlayerIdentifiers(source))
	local identifierstring = ""
	if a ~= nil then
		identifierstring = identifierstring .. a .. "\n"
	end

	if b ~= nil then
		identifierstring = identifierstring .. b .. "\n"
	end

	if c ~= nil then
		identifierstring = identifierstring .. c .. "\n"
	end

	if d ~= nil then
		identifierstring = identifierstring .. d .. "\n"
	end

	if e ~= nil then
		identifierstring = identifierstring .. e .. "\n"
	end

	if f ~= nil then
		identifierstring = identifierstring .. f .. "\n"
	end

	if g ~= nil then
		identifierstring = identifierstring .. g .. "\n"
	end
	return identifierstring
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'ae', "supporter", function(source, args, user)
    local xPlayers = ESX.GetPlayers()
    local argString = table.concat(args, " ")
    if argString ~= nil then
    for i=1, #xPlayers, 1 do    
    TriggerClientEvent('lara_notifyannounce:display', xPlayers[i], 'Admin Nachricht', argString, 15000, false)
    end
end
end)

RegisterCommand("id", function(source, args)
    TriggerClientEvent('notifications', source, "#029488", "ID", "Deine ID ist: " .. source)
end, false)