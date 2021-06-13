ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('night_rent:checkPrie', function(source,cb, money) 
    local xPlayer = ESX.GetPlayerFromId(source)
    print(money)
	local have = xPlayer.getMoney()
	print(have)
	if money ~= nil then  
		if have >= money then
			print('si')
			cb(true)
		else
			print('no')
			cb(false)
		end
	end
end)

RegisterServerEvent('night_money:true')
AddEventHandler('night_money:true', function(dinero)
    local user = source
    local xPlayer = ESX.GetPlayerFromId(user)

    if xPlayer then
        xPlayer.removeAccountMoney('money',dinero)
    end
end)  

