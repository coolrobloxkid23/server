-- Server-side Script (ServerScriptService)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create RemoteEvents to communicate with clients
local playAudioEvent = Instance.new("RemoteEvent")
playAudioEvent.Name = "PlayAudioEvent"
playAudioEvent.Parent = ReplicatedStorage

local changeSkyboxEvent = Instance.new("RemoteEvent")
changeSkyboxEvent.Name = "ChangeSkyboxEvent"
changeSkyboxEvent.Parent = ReplicatedStorage

-- Function to send a play audio request to the client
local function playScaryAudio(player)
    playAudioEvent:FireClient(player, "rbxassetid://9043345732")  -- Scary sound ID
end

-- Function to send a change skybox request to the client
local function changeScarySkybox(player)
    changeSkyboxEvent:FireClient(player, "rbxassetid://10798732439")  -- Scary skybox ID
end

-- Example usage - trigger these when the player joins the game
game.Players.PlayerAdded:Connect(function(player)
    playScaryAudio(player)
    changeScarySkybox(player)
end)
