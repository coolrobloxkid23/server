-- Server-side script (for the script in GitHub)
game.ReplicatedStorage.GearRequest.OnServerEvent:Connect(function(player, gearId)
    -- Check if the player has permission (you can add custom checks here)
    if player and gearId then
        local gear = game:GetService("InsertService"):LoadAsset(gearId)
        
        for _, item in pairs(gear:GetChildren()) do
            if item:IsA("Tool") then
                item.Parent = player.Backpack -- Give gear to the player's inventory
            end
        end
    end
end)
