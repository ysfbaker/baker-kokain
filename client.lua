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
                event = "baker-kokain:startCollect",
                icon = "fas fa-cannabis",
                label = "Kokain Topla"
            }
        },
        distance = 2
    })
end)

RegisterNetEvent("baker-kokain:startCollect")
AddEventHandler("baker-kokain:startCollect", function()
    if not collecting then
        collecting = true
        TriggerEvent("baker-kokain:startProgressBar")
    end
end)

RegisterNetEvent("baker-kokain:collect")
AddEventHandler("baker-kokain:collect", function()
    TriggerServerEvent("baker-kokain:reward")
    ClearPedTasks(PlayerPedId())
    collecting = false
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
        end, function()
            StopAnimTask(ped, "missmechanic", "work_base", 1.0)
            QBCore.Functions.Notify("Toplamayı Bıraktın.", "error")
        end)
    else
        QBCore.Functions.Notify("Seni gerizekalı bir işi beceremedin!", "error", 5000)
    end
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

local function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end

local function processkokain()
    local count = 0
    if(count == 0) then
		local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
		LoadDict(dict)
		FreezeEntityPosition(GetPlayerPed(-1),true)
		TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		local PedCoords = GetEntityCoords(GetPlayerPed(-1))
		local yarra = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
		AttachEntityToEntity(yarra, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
		SetEntityHeading(GetPlayerPed(-1), 311.0)
		local nane = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
		SetEntityRotation(nane,90.0, 0.0, 45.0, 1,true)
		Wait(5000)
		FreezeEntityPosition(GetPlayerPed(-1),false)
		DeleteEntity(nane)
		DeleteEntity(yarra)
		ClearPedTasks(PlayerPedId())
	
    	TriggerServerEvent("baker-kokain:kokainpaket")
    end
end

RegisterNetEvent('baker-kokain:paket', function()
	local hasItem = QBCore.Functions.HasItem('kokain', math.random(1, 2))
	if hasItem then
		QBCore.Functions.Progressbar('kokain_processing', "Kokain paketleniyor..", math.random(8500, 10000), false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			}, {
			animDict = 'mini@repair',
			anim = 'fixing_a_player',
			flags = 16,
			}, {}, {}, function()
				processkokain()
			end, function()
				QBCore.Functions.Notify("Başarıyla kokain paketlendi!", "success")
		end)
	else
		QBCore.Functions.Notify("Yeterli malzemen yok!", "error")
	end
end)