local code = "";

RegisterNetEvent('lara_dialogs:dialog')
AddEventHandler('lara_dialogs:dialog', function(title, message, b)
    Wait(200)
    SendNUIMessage({
		title = title,
        message = message
    })

    
    code = b
    SetNuiFocus(true, true)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

end)

RegisterNUICallback('lara_dialog:callback', function(data, cb)
    SetNuiFocus(false, false)
    load(code)()

    cb('ok')
end)


RegisterNUICallback('lara_dialog:delcode', function(data, cb)
    SetNuiFocus(false, false)
    code = ""

    cb('ok')
end)

RegisterCommand("dialog", function(source)
    Citizen.CreateThread(function()
      TriggerEvent('lara_dialogs:dialog', "Old-V - Support", "Bitte finde dich umgehend im Support ein.")
    end)
end)
  