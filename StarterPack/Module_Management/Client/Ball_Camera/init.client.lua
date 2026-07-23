local UIS = game:GetService("UserInputService")
local DesiredKey = Enum.KeyCode.Backspace

UIS.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == DesiredKey then
		script.Parent.Parent.Parent.Parent.PlayerGui.Start.Cameras.Visible = not script.Parent.Parent.Parent.Parent.PlayerGui.Start.Cameras.Visible 
		script.Success:Play()
	end
end)