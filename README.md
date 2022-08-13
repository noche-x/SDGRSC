# SDGRSC
SDGSRC is a plugin for RosaServerCore to enable logging whatever number you want to see across time.
This plugin logs player, item and vehicle counts.

## Usage
To use this plugin you need RosaServer and RosaServerCore installed in your server.
Put `sdgSR.lua` in your `plugins/` folder.

## Extending
Hook `AddSDGData` anywhere, index the first parameter with a string and assign a value to it.

Example
```
plugin:addHook("AddSDGData", function (sdgData)
	local totalAccountBalance = 0
	for _, account in ipairs(accounts.getAll()) do
		totalAccountBalance = totalAccountBalance + account.money
	end
	sdgData.totalAccountBalance = totalAccountBalance
end)
```
