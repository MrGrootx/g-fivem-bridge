if GetResourceState("qb-core") ~= "started" then
	return
end

QBCore = exports["qb-core"]:GetCoreObject()

function ShowNotification(target, text)
	TriggerClientEvent(GetCurrentResourceName() .. ":showNotification", target, text)
end

function GetIdentifier(src)
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		return xPlayer.PlayerData.citizenid
	end
	return nil
end

function AddMoney(src, count)
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		xPlayer.Functions.AddMoney("cash", count)
	end
end

function RemoveMoney(src, count)
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		xPlayer.Functions.RemoveMoney("cash", count)
	end
end

function GetMoney(src)
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		return xPlayer.PlayerData.money.cash
	end
	return 0
end

function GetItemCount(src, name)
	local _source = tonumber(src)
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	if xPlayer then
		local item = xPlayer.Functions.GetItemByName(name)
		return item and item.amount or 0
	end
	return 0
end

function RegisterUsableItem(itemName, cb)
	QBCore.Functions.CreateUseableItem(itemName, cb)
end

function AddItem(src, name, count, metadata)
	local _source = tonumber(src)
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	if xPlayer then
		xPlayer.Functions.AddItem(name, count, nil, metadata)
	end
end

function RemoveItem(src, name, count)
	local _source = tonumber(src)
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	if xPlayer then
		xPlayer.Functions.RemoveItem(name, count)
	end
end

function CheckPermission(src, permission)
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if not xPlayer then
		return false
	end

	local name = xPlayer.PlayerData.job.name
	local rank = xPlayer.PlayerData.job.grade.level

	if permission.jobs[name] and permission.jobs[name] <= rank then 
		return true
	end

	for i = 1, #permission.groups do 
		if QBCore.Functions.HasPermission(src, permission.groups[i]) then 
			return true 
		end
	end

	for i = 1, #permission.ace do 
		if IsPlayerAceAllowed(src, permission.ace[i]) then 
			return true 
		end
	end

	return false
end
