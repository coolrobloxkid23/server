local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remote = ReplicatedStorage:WaitForChild("GearGiver")

Remote.OnServerEvent:Connect(function(player, gearID)
	if typeof(gearID) == "number" then
		local success, gear = pcall(function()
			return game:GetService("InsertService"):LoadAsset(gearID)
		end)
		
		if success and gear then
			local tool = gear:FindFirstChildOfClass("Tool")
			if tool then
				tool.Parent = player.Backpack
			end
		end
	end
end)
