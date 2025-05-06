
return function(_K)
	local requiredRank = 4
	
	local function CheckForLoadString()
		local s,e = pcall(function()
			loadstring("local a = nil")()
		end)
		if s then
			return true
		else
			return false, e
		end
	end
	
	_K.Registry.registerCommand(_K, {
		name = "loadstring",
		aliases = {"s","MakeScript","script"},
		description = "Executes a script",

		group = "General",

		args = {
			{
				type = "stringGreedy",
				name = "Script",
				description = "The script to be executed", -- Description shown in command list.
				-- If the command is optional, make sure to check if it's nil and not false!
				optional = true,

				lowerRank = false,
				ignoreSelf = false,
				shouldRequest = false,
			},
		},

		run = function(context,Script)
			
			print(Script)
			if CheckForLoadString() then
				if context.fromRank < requiredRank then
					context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = `Invalid permissions you need rank: `.. requiredRank .. ' or higher.' })
					return
				end
				local s,e = pcall(function()
					loadstring(Script)()
				end)
				if not s then
					context._K.Remote.Notify:FireClient(context.fromPlayer,{
						Text = "<font color = \"rgb(245, 50, 50)\">" .. " ".. e .. " " .. "</font>",
					})
				end
				
			else
				context._K.Remote.Notify:FireClient(context.fromPlayer,{
					Text = "<font color = \"rgb(245, 50, 50)\">" .. "This command requires loadstring. loadstring can be EXTREMELY DANGEROUS if you do not know what you're doing. If you are a developer of this game please research the topic before enabling." .. "</font>",
				})
			end
			
		end,
	})
end
