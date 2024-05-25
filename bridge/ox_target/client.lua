if GetResourceState("ox_target") ~= "started" then
	return
end
if Config.settings.Debug then
	local filename = function()
		 local str = debug.getinfo(2, "S").source:sub(2)
		 return str:match("^./(.).lua$") or str
	end
	print("^4[SERVER - DEBUG] ^0: "..filename()..".lua started");
end

function AddTargetModel(models, radius, options)
	local optionsNames = {}
	for i = 1, #options do
		optionsNames[i] = options[i].name
	end
	RemoveTargetModel(models, optionsNames)
	exports.ox_target:addModel(models, options)
end

function RemoveTargetModel(models, optionsNames)
	exports.ox_target:removeModel(models, optionsNames)
end

function AddTargetZone(coords, radius, options)
	return exports.ox_target:addSphereZone({
		coords = coords,
		radius = radius,
		options = options,
	})
end

function RemoveTargetZone(index)
	exports.ox_target:removeZone(index)
end
