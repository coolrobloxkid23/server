-- Server Script: Change Skybox and Play Audio for All Players
local soundId = "rbxassetid://9043345732" -- Scary Audio ID
local skyboxId = "rbxassetid://10798732439" -- Scary Skybox ID
local lighting = game:GetService("Lighting")

-- Function to play sound for all players
local function playScaryAudio()
    for _, player in ipairs(game.Players:GetPlayers()) do
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Parent = player.Character or player:WaitForChild("Character")
        sound:Play()
    end
end

-- Function to change skybox for all players
local function changeSkybox()
    local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", lighting)
    sky.SkyboxBk = skyboxId
    sky.SkyboxDn = skyboxId
    sky.SkyboxFt = skyboxId
    sky.SkyboxLf = skyboxId
    sky.SkyboxRt = skyboxId
    sky.SkyboxUp = skyboxId
end

-- Play audio and change skybox for all players when the server starts
playScaryAudio()
changeSkybox()
