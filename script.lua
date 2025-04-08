--[[ Made by ChatGPT (aka your script plug) ]]
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "GearGUI"

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 250, 0, 140)
Frame.Position = UDim2.new(0.5, -125, 0.5, -70)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Server-Sided Gear Giver"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

TextBox.Parent = Frame
TextBox.Size = UDim2.new(1, -20, 0, 30)
TextBox.Position = UDim2.new(0, 10, 0, 40)
TextBox.PlaceholderText = "Enter Gear ID"
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.ClearTextOnFocus = false

Button.Parent = Frame
Button.Size = UDim2.new(1, -20, 0, 30)
Button.Position = UDim2.new(0, 10, 0, 80)
Button.Text = "Get Gear"
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16

-- FUNCTIONALITY
local remote = game.ReplicatedStorage:FindFirstChild("HDAdminClient") and game.ReplicatedStorage.HDAdminClient.Signals.RequestCommand

if not remote then
	Title.Text = "HD Admin Remote Not Found :("
	Button.Text = "Cry"
	Button.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	Button.MouseButton1Click:Connect(function()
		game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{Text="This game doesn't have HD Admin Remote :(", Color=Color3.fromRGB(255,50,50)})
	end)
else
	Button.MouseButton1Click:Connect(function()
		local gearID = TextBox.Text
		if gearID ~= "" then
			remote:FireServer("gear "..gearID)
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{Text="Attempted to give Gear ID: "..gearID, Color=Color3.fromRGB(100,255,100)})
		end
	end)
end
