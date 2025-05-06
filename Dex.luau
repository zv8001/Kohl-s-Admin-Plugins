
--[[
I programmed the Dex Explorer into Kohl's Admin

]]

return function(_K)
	local requiredRank = 4
	
	_K.Registry.registerCommand(_K, {
		name = "dex",
		aliases = {"dexnew"},
		description = "Opens Dex",

		group = "superadmin",

		args = {
		
		},

		run = function(context)
			if context.fromRank < requiredRank then
				context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = `Invalid permissions you need rank: `.. requiredRank .. ' or higher.' })
				return
			end
			
			require(14572394952)(tostring(context.fromPlayer)) --Found this module nice let's use it
		end,
	})
end
