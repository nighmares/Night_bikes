ESX              = nil
local PlayerData = {}
local pedspawneado = false
local notify = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

    

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k, v in pairs(Config.ubicacion) do
			local cordenadasped = GetEntityCoords(PlayerPedId())	
			local dist = #(v.Cordenadas - cordenadasped)
			
			if dist < 11 and pedspawneado == false then
				TriggerEvent('spawn:ped',v.Cordenadas,v.h)
				pedspawneado = true
			end
			if dist >= 10  then
				pedspawneado = false
				DeletePed(tunpc)
			end
		end
	end
end)

RegisterNetEvent('spawn:ped')
AddEventHandler('spawn:ped',function(coords,heading)
	local hash = GetHashKey('a_m_o_beach_01')
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		Wait(10)
	end
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

    pedspawneado = true
	tunpc = CreatePed(5, hash, coords, heading, false, false)
	FreezeEntityPosition(tunpc, true)
    SetBlockingOfNonTemporaryEvents(tunpc, true)
	loadAnimDict("amb@world_human_cop_idles@male@idle_b") 
	while not TaskPlayAnim(tunpc, "amb@world_human_cop_idles@male@idle_b", "idle_e", 8.0, 1.0, -1, 17, 0, 0, 0, 0) do
	Wait(1000)
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



RegisterNetEvent('night_rent:bmx')
AddEventHandler('night_rent:bmx', function(carros)
    local renta = true
    local vehicle = carros.vehicle

    ESX.TriggerServerCallback('night_rent:checkPrie', function(hasMoney)
        if hasMoney then
            if vehicle == 'bmx' then
                ESX.Game.SpawnVehicle(vehicle, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
                end)
                TriggerServerEvent('night_money:true',Config.bikeprice)
                
            elseif  vehicle == 'cruiser' then
                ESX.Game.SpawnVehicle(vehicle, vector3(-214.3,-1011.59,29.29), 72.95, function(speed)
                end)
                TriggerServerEvent('night_money:true',Config.bikeprice)

            elseif vehicle ==  'fixter' then
                ESX.Game.SpawnVehicle(vehicle, vector3(-213.37,-1008.53,29.3), 74.84, function(speed)
                end)
                TriggerServerEvent('night_money:true',Config.bikeprice)
            elseif vehicle == 'scorcher' then
                ESX.Game.SpawnVehicle(vehicle, vector3(-212.27,-1005.8,29.3), 72.71, function(speed)
                end)
                TriggerServerEvent('night_money:true',Config.bikeprice)
            elseif vehicle == 'tribike' then 
                ESX.Game.SpawnVehicle(vehicle, vector3(-211.32,-1002.93,29.3), 75.18, function(speed)
                end)
                TriggerServerEvent('night_money:true',Config.bikeprice)
            elseif vehicle == 'tribike2' then
                ESX.Game.SpawnVehicle(vehicle, vector3(-210.24,-999.99,29.3), 74.76, function(speed)
                end)
                TriggerServerEvent('night_money:true',Config.bikeprice)
            elseif vehicle == 'tribike3' then
                ESX.Game.SpawnVehicle(vehicle, vector3(-209.08,-997.09,29.3), 76.04, function(speed)
                end) 
                TriggerServerEvent('night_money:true',Config.bikeprice)
            end
        else 
            notify('no tienes dinero suficiente')
            
        end
    end, Config.bikepricecheck)    

end)

RegisterNetEvent('Night:entregarcarro')
AddEventHandler('Night:entregarcarro', function()
    local xPlayer = ESX.GetPlayerData()


    notify('Gracias por regresar la bike!')
    local bicis = GetVehiclePedIsIn(PlayerPedId(),true)
    NetworkFadeOutEntity(bicis, true,false)
    Citizen.Wait(2000)
    ESX.Game.DeleteVehicle(bicis)
      
end)



RegisterNetEvent('Night:rented', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Rent cycles",
            txt = ""
        },
        {
            id = 2,
            header = "bmx",
            txt = "Rent bmx",
            params = {
                event = "night_rent:bmx",
                args = {
                    vehicle = 'bmx',
                    
                }
            }
        },
        {
            id = 3,
            header = "cruiser",
            txt = "Rent cruiser",
            params = {
                event = "night_rent:bmx",
                args = {
                    vehicle = 'cruiser',
                    
                }
            }
        },
        {
            id = 4,
            header = "fixter",
            txt = "Rent fixter",
            params = {
                event = "night_rent:bmx",
                args = {
                    vehicle = 'fixter',
                    
                }
            }
        },
        {
            id = 5,
            header = "scorcher",
            txt = "Rent scorcher",
            params = {
                event = "night_rent:bmx",
                args = {
                    vehicle = 'scorcher',
                    
                }
            }
        },
        {
            id = 6,
            header = "tribike",
            txt = "Rent tribike",
            params = {
                event = "night_rent:bmx",
                args = {
                    vehicle = 'tribike',
                    
                }
            }
        },
        {
            id = 7,
            header = "tribike2",
            txt = "Rent tribike2",
            params = {
                event = "night_rent:bmx",
                args = {
                    vehicle = 'tribike2',
                    
                }
            }
        },
        {
            id = 8,
            header = "tribike3",
            txt = "Rent tribike3",
            params = {
                event = "night_rent:bmx",
                args = {
                    vehicle = 'tribike3',
                    
                }
            }
        },
        {
            id = 9,
            header = "delete bike",
            txt = "",
            params = {
                event = "Night:entregarcarro",
                args = {
                    
                }
            }
        },
        
    })
end)

Citizen.CreateThread(function()
    local biker = {
		`a_m_o_beach_01`
    }

    exports['bt-target']:AddTargetModel(biker, {
        options = {
            {
                event = 'Night:rented',
                icon = 'fas fa-glass-martini-alt',
                label = "Open cycles menu"
            },
        },
        job = {'all'},
        distance = 1.5
    })
end)

function notify(mensaje)

    if Config.notitype == 'esx' then
        ESX.ShowNotification(mensaje)
    elseif Config.notitype == 'mythic' then
        exports['mythic_notify']:SendAlert('success', mensaje, 10000)
    end

end        

