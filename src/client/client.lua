print("hi this is inside src print [client]")
if Config.settings.Debug then
	local filename = function()
		local str = debug.getinfo(2, "S").source:sub(2)
		return str:match("^./(.).lua$") or str
	end
	print("^4[SERVER - DEBUG] ^0: " .. filename() .. ".lua started")
end

RegisterCommand("bridge", function(source, args, rawCommand)
	local playerId = source

	ShowNotification("yeah its me")
end, false)

