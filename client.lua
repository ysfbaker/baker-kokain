local collecting = false
local QBCore = exports["qb-core"]:GetCoreObject()

CreateThread(function()
    exports['qb-target']:AddBoxZone("kokain", vector3(5212.83, -5128.38, 6.01), 1.0, 8.0, {
        name = "kokain",
        heading = 275,
        debugPoly = false,
        minZ = 0.01,
        maxZ = 6.51
    }, {
        options = {
            {
                event = "baker-kokain:startProgressBar",
                icon = "fas fa-cannabis",
                label = "Kokain Topla"
            }
        },
        distance = 2
    })
end)

RegisterNetEvent("baker-kokain:collect")
AddEventHandler("baker-kokain:collect", function()
    TriggerServerEvent("baker-kokain:reward")
    ClearPedTasks(PlayerPedId())
    collecting = false
end)


CreateThread(function()
    exports['qb-target']:AddBoxZone("kokainpaket", vector3(173.93, 2220.53, 90.75), 1.0, 8.0, {
        name = "kokainpaket",
        heading = 141,
        debugPoly = false,
        minZ = 70.01,
        maxZ = 91.51
    }, {
        options = {
            {
                event = "baker-kokain:paket",
                icon = "fas fa-box",
                label = "Kokain Paketle"
            }
        },
        distance = 2
    })
end)

RegisterNetEvent('baker-kokain:paket', function()
	local hasItem = QBCore.Functions.HasItem('kokain', math.random(1, 2))
	if hasItem then
		QBCore.Functions.Progressbar('kokain_processing', "Kokain paketleniyor..", math.random(8500, 10000), false, true, {
			disableMovement = true,
            canCancel = false,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			}, {
			animDict = 'mini@repair',
			anim = 'fixing_a_player',
			flags = 16,
			}, {}, {}, function()
                TriggerServerEvent("baker-kokain:kokainpaket")
				QBCore.Functions.Notify("Başarıyla kokain paketlendi!", "success")
			end, function()
		end)
	else
		QBCore.Functions.Notify("Yeterli malzemen yok!", "error")
	end
end)

CreateThread(function()
    local pedModel = "s_m_m_ammucountry"
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(500)
    end
    local ped = CreatePed(4, pedModel, vector4(173.99, 2220.56, 89.83, 157), 0.0, true, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
end)

    RegisterNetEvent("baker-kokain:startProgressBar")
    AddEventHandler("baker-kokain:startProgressBar", function()
        local minigame = exports['qb-lock']:StartLockPickCircle(5,10)
        if minigame then
            QBCore.Functions.Progressbar("Kokain", "Kokain toplanıyor..", 5000, false, true,{
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }, {}, {}, function()
                TriggerEvent("baker-kokain:collect")
            end)
        else
            QBCore.Functions.Notify("Seni gerizekalı bir işi beceremedin!", "error", 5000)
        end
    end)
