-- Server-Side Script for Gear Insertion via GUI
-- This script will allow players to paste a gear ID into a GUI and receive the gear in their inventory.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")

-- Create a RemoteEvent for communication
local gearRequestEvent = Instance.new("RemoteEvent")
gearRequestEvent.Name = "GearRequestEvent"
gearRequestEvent.Parent = ReplicatedStorage

-- Function to insert gear for a player based on gear ID input
local function insertGear(assetId, player)
    -- Validate asset ID
    if not tonumber(assetId) then
        return false, "Invalid Gear ID"
    end

    -- Convert to number and check for valid asset ID
    local gearId = tonumber(assetId)
    local gear = InsertService:LoadAsset(gearId)

    if gear then
        -- Add gear to player's character inventory
        local character = player.Character or player.CharacterAdded:Wait()
        gear.Parent = character
        gear:MakeJoints()  -- Attach the gear to the player's character
        return true
    else
        return false, "Gear not found"
    end
end

-- Listen for remote event to handle gear request
gearRequestEvent.OnServerEvent:Connect(function(player, gearId)
    local success, message = insertGear(gearId, player)
    if success then
        -- Notify player they received the gear
        player:SendNotification({Title = "Success!", Text = "You have received the gear!"})
    else
        -- Notify player of an error (invalid ID or failure)
        player:SendNotification({Title = "Error", Text = message})
    end
end)

-- Client-Side GUI (Script to be placed in a LocalScript for the client)
local function createGUI(player)
    -- Create the main GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    screenGui.Name = "GearInsertionGUI"

    -- Create the main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Active = true
    mainFrame.Draggable = true

    -- Create the Title
    local title = Instance.new("TextLabel")
    title.Parent = mainFrame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.SourceSansBold
    title.Text = "Enter Gear ID"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18

    -- Create a TextBox for gear ID input
    local gearIdBox = Instance.new("TextBox")
    gearIdBox.Parent = mainFrame
    gearIdBox.Position = UDim2.new(0.5, -100, 0.3, 0)
    gearIdBox.Size = UDim2.new(0, 200, 0, 30)
    gearIdBox.Font = Enum.Font.SourceSans
    gearIdBox.PlaceholderText = "Enter Gear ID"
    gearIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    gearIdBox.TextSize = 14

    -- Create an Enter Button
    local enterButton = Instance.new("TextButton")
    enterButton.Parent = mainFrame
    enterButton.Position = UDim2.new(0.5, -50, 0.6, 0)
    enterButton.Size = UDim2.new(0, 100, 0, 40)
    enterButton.Font = Enum.Font.SourceSansBold
    enterButton.Text = "Enter"
    enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    enterButton.TextSize = 16
    enterButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

    -- Button click event to send Gear ID to server
    enterButton.MouseButton1Click:Connect(function()
        local gearId = gearIdBox.Text
        if gearId and gearId ~= "" then
            -- Send the Gear ID to the server to insert the gear
            gearRequestEvent:FireServer(gearId)
        else
            -- Show an error notification if the Gear ID is empty
            player:SendNotification({Title = "Error", Text = "Please enter a valid Gear ID!"})
        end
    end)
end

-- Create the GUI when the player joins the game
game.Players.PlayerAdded:Connect(function(player)
    -- Wait until the player's character is added
    player.CharacterAdded:Wait()
    
    -- Create GUI for the player
    createGUI(player)
end)
