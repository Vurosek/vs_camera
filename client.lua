local camMode = "none"


local function manageCameraAndShooting()
    local playerPed = PlayerPedId()
    
    if camMode == "first" then
        
        if IsPlayerFreeAiming(PlayerId()) and GetFollowPedCamViewMode() ~= 4 then
            SetFollowPedCamViewMode(4)
        end
        
        
        if GetFollowPedCamViewMode() ~= 4 then
            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 142, true) 
            DisableControlAction(0, 257, true) 
            DisableControlAction(0, 263, true)
        end
    elseif camMode == "third" then
    
        if IsPlayerFreeAiming(PlayerId()) and GetFollowPedCamViewMode() == 4 then
            SetFollowPedCamViewMode(1)
        end
        
        
        if GetFollowPedCamViewMode() == 4 then
            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 142, true) 
            DisableControlAction(0, 257, true) 
            DisableControlAction(0, 263, true) 
        end
    end
end


RegisterCommand('kamera', function()
    lib.registerContext({
        id = 'vs_camera_menu',
        title = '🎥Wybierz tryb kamery🎥',
        options = {
            {
                icon = 'fa-solid fa-users',
                title = 'Blokada strzelania w trzeciej osobie',
                description = 'Blokuje strzelanie w trybie trzeciej osoby',
                event = 'vs_camera:blockThirdPerson'

            },
            {
                icon = "fa-solid fa-user",
                title = ' Blokada strzelania w pierwszej osobie',
                description = 'Blokuje strzelanie w trybie pierwszej osoby',
                event = 'vs_camera:blockFirstPerson'
            },
            {
                icon = 'fa-solid fa-x',
                title = 'Wyłącz blokadę strzelania',
                description = 'Wyłącza blokadę strzelania w obu trybach',
                event = 'vs_camera:unblock'
            }
        }
    })
    lib.showContext('vs_camera_menu')
end)



RegisterNetEvent('vs_camera:blockFirstPerson', function()
    camMode = "first"
    lib.notify({
        title = 'Wybór Kamery',
        description = 'Ustawiłeś Kamerę 1',
        type = 'success'
    })
end)

RegisterNetEvent('vs_camera:blockThirdPerson', function()
    camMode = "third"


    lib.notify({
        title = 'Wybór Kamery',
        description = 'Ustawiłeś Kamerę 3',
        type = 'success'
    })
end)

RegisterNetEvent('vs_camera:unblock', function()
    camMode = "none"
    lib.notify({
        title = 'Wybór Kamery',
        description = 'Ustawiłeś Domyślne Ustawienia kamery ',
        type = 'success'
    })
end)


CreateThread(function()
    while true do
        Wait(0)
        manageCameraAndShooting()
    end
end)
