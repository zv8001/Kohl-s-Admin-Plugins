--[[
# plugin to server ban people with Kohl's Admin

This is a pretty early and rushed version I'm probably going to update it later.
Made by z3ck200


https://github.com/zv8001/Kohl-s-Admin-Plugins
https://www.roblox.com/users/4071774573/profile
]]


return function(_K)
	local Players = game:GetService("Players")
	
	if not (_K.ServerBans == nil) then --Just in case
		return
	end
	
	_K.ServerBans = {}
	
	local function CheckPlayer(UserId)
		for i,v in pairs(_K.ServerBans) do
			if v[1] == UserId then
				return v[2]
			end
		end
		return false
	end
	
	local function RunCheckCode(Player)
		local Check = CheckPlayer(Player.UserId)
		
		if Check then
			Player:Kick("You have been server banned reason: | " .. Check)
		end
	end
	
	game.Players.PlayerAdded:Connect(RunCheckCode)
	
	local function CheckAllPlayers()
		for i,v in pairs(Players:GetPlayers()) do
			RunCheckCode(v)
		end
	end
	

	
	_K.Registry.registerCommand(_K, {
		name = "ServerBan",
		aliases = {"sban"},
		description = "Server Ban Someone",

		group = "Moderation",
		args = {
			{
				type = "string",
				name = "Player",
				description = "Player",
				optional = false,

				lowerRank = false,
				ignoreSelf = false,
				shouldRequest = false,
			},
			{
				type = "stringGreedy",
				name = "Reason",
				description = "The reason of the ban",
				optional = false,

				lowerRank = false,
				ignoreSelf = false,
				shouldRequest = false,
			},
		},

		run = function(context, player,Res)
			
			local result,Msg = pcall(function()
				return Players:GetUserIdFromNameAsync(player)
			end)
			
			if result then
				if not CheckPlayer(Msg) then
					local BanInfo = {Msg,Res}
					table.insert(_K.ServerBans,BanInfo)
					context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = player .. ` has been server banned.` })
					CheckAllPlayers()
				else
					context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = player .. ` has already been server banned.` })
				end
				
			else
				context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = `invalid player` })
			end
			
			
		end,
	})
	
	
	_K.Registry.registerCommand(_K, {
		name = "UnServerBan",
		aliases = {"unsban"},
		description = "un-server Ban Someone",

		group = "Moderation",
		args = {
			{
				type = "string",
				name = "PlayerUsername",
				description = "Player",
				optional = false,

				lowerRank = false,
				ignoreSelf = false,
				shouldRequest = false,
			},
		},

		run = function(context, player,Res)
			
			local r,m = pcall(function()
				return Players:GetUserIdFromNameAsync(player)
			end)
			
			if r then
				local S = false
				for index,Data in pairs(_K.ServerBans) do
					if Data[1] == m then
						S=true
						context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = player .. ` has been unbanned.` })
						table.remove(_K.ServerBans,index)
					end
				end
				if not S then
					context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = player .. ` is not banned currently` })
				end
			else
				context._K.Remote.Notify:FireClient(context.fromPlayer, { Text = `invalid player` })
			end
		end,
	})
	
end
