---@type Plugin
local plugin = ...
plugin.name = "SDG Sub Rosa"
plugin.author = "noche"
plugin.description = "Logs data at fixed intervals for SDG. Check out github.com/noche-x/SDG for instructions"

plugin.defaultConfig = {
	-- Interval for logging in seconds
	interval = 5,
}

local lastLogTime
local startEpoch

plugin:addEnableHandler(function()
	if os.createDirectory("dataSDG") then
		plugin:print("Created SDG log directory")
	end

	lastLogTime = 0
	startEpoch = os.time()
end)

plugin:addDisableHandler(function()
	lastLogTime = nil
	startEpoch = nil
end)

plugin:addHook("Logic", function()
	local now = os.realClock()
	if now - lastLogTime >= plugin.config.interval then
		lastLogTime = now

		local sdgLineData = {}
		if hook.run("AddSDGData", sdgLineData) then
			return
		end

		sdgLineData.playerCount = players.getCount()
		sdgLineData.itemCount = items.getCount()
		sdgLineData.vehicleCount = vehicles.getCount()
		sdgLineData.humansCount = humans.getCount()

		local epochDelta = os.time() - startEpoch
		local line = "time=" .. epochDelta .. ","
        for k,v in pairs(sdgLineData) do
            line = line .. k .. "=" .. v .. ","
        end
        line = line:sub(1, -2)

		local file = io.open("dataSDG/" .. os.date("%Y-%m-%d") .. ".txt", "a")
		file:write(line .. "\n")
		file:close()
	end
end)
