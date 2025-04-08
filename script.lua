local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create RemoteEvent for communication
local remote = Instance.new("RemoteEvent")
remote.Name = "GearInserterRemote"
remote.Parent = ReplicatedStorage

-- Function to give gear server-sided
local function giveGear(player, gearID)
    -- Check if gearID is valid
    local success, gear = pcall(function()
        return game:GetService("InsertService"):LoadAsset(gearID)
    end)

    if success and gear then
        local gearItem = gear:FindFirstChildOfClass("Tool")
        if gearItem then
            gearItem.Parent = player.Backpack
        else
            warn("No tool found in asset.")
        end
    else
        warn("Invalid Gear ID.")
    end
end

-- Listen for client requests
remote.OnServerEvent:Connect(function(player, gearID)
    giveGear(player, gearID)
end)
