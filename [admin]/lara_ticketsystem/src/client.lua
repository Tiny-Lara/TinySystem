local isOpen = false 
local admin = false
ESX = nil

Citizen.CreateThread(function()
   while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
   end
end)

RegisterCommand(Config.Commands.oeffnen, function()
   ESX.TriggerServerCallback('check', function(group) 
      if group == "guide" 
      or group == "supporter" 
      or group == "moderator" 
      or group == "dev" 
      or group == "administrator" 
      or group == "headadmin" 
      or group == "manager" 
      or group == "projektleitung" 
      then
         if not isOpen  then 
         TriggerEvent('lara:open')
         isOpen = true 
         SetNuiFocus(true, true)
         end

      else 
         ESX.ShowNotification("no perms")
      end
  end)
end)

RegisterNetEvent('lara:open')
AddEventHandler('lara:open', function()

   SendNUIMessage({
      type = "clearTickets"
   })

   SendNUIMessage({
      type = "openHTML"
   })

   TriggerServerEvent('lara:loadTickets')
end)

RegisterNetEvent('ticketnotify')
AddEventHandler('ticketnotify', function(title, msg)
    ESX.TriggerServerCallback('TL:getGroup', function(group)
      if group == "guide" 
      or group == "supporter" 
      or group == "moderator" 
      or group == "dev" 
      or group == "administrator" 
      or group == "headadmin" 
      or group == "manager" 
      or group == "projektleitung" 
      then
            TriggerEvent('notifications', "#029488", "TICKET - " .. title, "Grund: " .. msg)
        end
    end)
end)

RegisterNetEvent('lara:addTicket')
AddEventHandler('lara:addTicket', function(name, id, msg, ticketid)
    
    SendNUIMessage({
        type = "addTicket",
        name = name,
        id = id,
        msg = msg,
        ticketid = ticketid
   })

end)

RegisterNUICallback('closeTicket', function(data, cb)
   TriggerServerEvent('lara:closeTicket', data.id)
   SendNUIMessage({
       type = "clearTickets"
   })

   TriggerServerEvent('lara:loadTickets')
   cb('ok')
end)

RegisterNUICallback('revive', function(data, cb)
  TriggerServerEvent('lara:revive', data.id)
end) 

RegisterNUICallback('goto', function(data, cb)
   TriggerServerEvent("lara:goto", data.id)
end)

RegisterNUICallback('bring', function(data, cb)
   TriggerServerEvent("lara:bring", data.id)
end)

RegisterNetEvent('lara:teleportUser')
AddEventHandler('lara:teleportUser', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z)
end)

RegisterNUICallback('close', function(data, cb)
   SetNuiFocus(false, false)
   isOpen = false 
end)

RegisterNUICallback('kill', function(data, cb)
   TriggerServerEvent("lara:kill", data.id)
end)

RegisterNetEvent('laravallahclient:kill')
AddEventHandler('laravallahclient:kill', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNUICallback('kick', function(data, cb)
   TriggerServerEvent("lara:kick", data.id)
end)

RegisterNUICallback('reload', function(data, cb)
   SendNUIMessage({
      type = "clearTickets"
   })

   TriggerServerEvent('lara:loadTickets')
   ESX.ShowNotification(Config.Messages.loadticketsmsg)
end)
