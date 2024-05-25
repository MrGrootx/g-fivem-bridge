if GetResourceState("qb-target") ~= "started" then
	return
end
if Config.settings.Debug then
	local filename = function()
		 local str = debug.getinfo(2, "S").source:sub(2)
		 return str:match("^./(.).lua$") or str
	end
	print("^4[SERVER - DEBUG] ^0: "..filename()..".lua started");
end

local Zones = {}

function AddTargetModel(models, radius, options)
    local optionsNames = {}
    for i = 1, #options do 
        optionsNames[i] = options[i].name
        if options[i].onSelect then
            local cb = options[i].onSelect
            options[i].action = function(entity)
                cb({entity = entity})
            end
            options[i].onSelect = nil
        end
    end
    RemoveTargetModel(models, optionsNames)
    exports['qb-target']:AddTargetModel(models, {options = options, distance = radius or 2.5})
end

function RemoveTargetModel(models, optionsNames)
    exports['qb-target']:RemoveTargetModel(models, optionsNames)
end

function AddTargetZone(coords, radius, options)
    local index
    repeat
        index = "lottery_coord_" .. math.random(1, 999999999)
    until not Zones[index]
    for i = 1, #options do 
        if options[i].onSelect then
            local cb = options[i].onSelect
            options[i].action = function(entity)
                cb({entity = entity})
            end
            options[i].onSelect = nil
        end
    end
    Zones[index] = true
    exports['qb-target']:AddCircleZone(index, coords, radius, {name = index}, {
        options = options
    })
    return index
end

function RemoveTargetZone(index)
    if not index or not Zones[index] then return end
    Zones[index] = nil
    exports['qb-target']:RemoveZone(index)
end
