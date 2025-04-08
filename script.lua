Button.MouseButton1Click:Connect(function()
	local gearID = TextBox.Text
	if gearID ~= "" then
		remote:InvokeServer("gear "..gearID)
		game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{Text="Attempted to give Gear ID: "..gearID, Color=Color3.fromRGB(100,255,100)})
	end
end)
