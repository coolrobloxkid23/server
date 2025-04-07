-- Services
local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local soundId = "rbxassetid://rbxassetid://9043345732" -- Replace with your scary sound ID
local skyboxId = "rbxassetid://rbxassetid://10798732439" -- Replace with your apocalyptic skybox ID

-- Remote Event for communication between client and server
local nukeEvent = Instance.new("RemoteEvent")
nukeEvent.Name = "NukeEvent"
nukeEvent.Parent = replicatedStorage

local backdoorEvent = Instance.new("RemoteEvent")
backdoorEvent.Name = "BackdoorEvent"
backdoorEvent.Parent = replicatedStorage

-- Nuke Server Function (Kick and Chaos)
local function nukeServer()
    -- Play the scary Nuke sound
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Parent = game.Workspace
    sound:Play()

    -- Create the explosion effect (Big Red Ball)
    local explosionEffect = Instance.new("Part")
    explosionEffect.Size = Vector3.new(100, 100, 100)
    explosionEffect.Shape = Enum.PartType.Ball
    explosionEffect.Anchored = true
    explosionEffect.CanCollide = false
    explosionEffect.Material = Enum.Material.Neon
    explosionEffect.Color = Color3.fromRGB(255, 0, 0)
    explosionEffect.Position = game.Workspace.CurrentCamera.CFrame.Position
    explosionEffect.Parent = game.Workspace

    wait(2) -- Explosion effect lasts for 2 seconds
    explosionEffect:Destroy()

    -- Change Skybox to something apocalyptic
    local skybox = Instance.new("Sky", lighting)
    skybox.SkyboxBk = skyboxId
    skybox.SkyboxDn = skyboxId
    skybox.SkyboxFt = skyboxId
    skybox.SkyboxLf = skyboxId
    skybox.SkyboxRt = skyboxId
    skybox.SkyboxUp = skyboxId
    wait(5) -- Skybox stays for 5 seconds
    skybox:Destroy()

    -- Temporarily kick all players with a spooky message
    for _, player in pairs(players:GetPlayers()) do
        if player.Character then
            player:Kick("You've been nuked! See you soon... and enjoy your 10k cash!")
        end
    end

    wait(5) -- Wait for the kick to finish

    -- Reward players with 10k cash after being kicked
    for _, player in pairs(players:GetPlayers()) do
        if player and player.UserId then
            -- Ensure player has a leaderstats and Cash stat
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats then
                local cash = leaderstats:FindFirstChild("Cash")
                if cash then
                    cash.Value = cash.Value + 10000
                end
            end

            -- Send a message to players that they’ve survived the nuke
            game.ReplicatedStorage:FireClient(player, "Nuked and survived! 10k Cash awarded for your bravery!")
        end
    end
end

-- Find Backdoors Function (Scan for Malicious Code)
local function findBackdoors()
    local suspiciousScripts = {}
    
    -- Scan function to find malicious code
    local function scan(obj)
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Script") or child:IsA("LocalScript") then
                local source = child.Source
                if source:find("require") or source:find("getfenv") then
                    table.insert(suspiciousScripts, child:GetFullName())
                end
            end
            scan(child)
        end
    end
    scan(game)
    
    -- Show result
    if #suspiciousScripts > 0 then
        -- If suspicious scripts are found, show a notification
        game.ReplicatedStorage:FireAllClients("Suspicious Scripts Found!")
        for _, scriptName in ipairs(suspiciousScripts) do
            warn("Suspicious script found: " .. scriptName)
        end
    else
        -- If no suspicious scripts found, show a "safe" message
        game.ReplicatedStorage:FireAllClients("No suspicious scripts found.")
    end
end

-- Nuke Server Trigger (when button is clicked on the client)
nukeEvent.OnServerEvent:Connect(function(player)
    nukeServer()
end)

-- Find Backdoors Trigger (when button is clicked on the client)
backdoorEvent.OnServerEvent:Connect(function(player)
    findBackdoors()
end)
