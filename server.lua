local QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) 
    QBCore = obj 
end)

RegisterServerEvent("baker-kokain:reward")
AddEventHandler("baker-kokain:reward", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.AddItem("kokain", 5)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["kokain"], "add")
        xPlayer.Functions.AddMoney("cash", 1000, "kokain-collected")
        TriggerClientEvent("QBCore:Notify", src, "Kokain toplandı!", "success")
    end
end)

RegisterServerEvent('baker-kokain:kokainial')
AddEventHandler('baker-kokain:kokainial', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.AddItem("kokain", math.random(1, 5))
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["kokain"], 'add')
end)

RegisterServerEvent("baker-kokain:kokainpaket")
AddEventHandler("baker-kokain:kokainpaket", function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("kokain", 5) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["kokain"], 'remove')
			QBCore.Functions.Notify("Heheee", "success")
			if Player.Functions.AddItem("paketlemiskokain") then
			    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["paketlemiskokain"], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, "Ben gayim")
            end
        else
    end
end)
