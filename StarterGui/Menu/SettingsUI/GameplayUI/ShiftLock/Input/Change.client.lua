repeat wait() until game:IsLoaded()

local RS = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Data = player:WaitForChild("PlayerData")
local SettingDataHolder = Data:WaitForChild("Settings"):WaitForChild("ShiftLock")
local Remotes = RS:WaitForChild("Data")
local ChangeData = Remotes:WaitForChild("ChangeData")

function change()
	local input = 1.75
	
	if script.Parent.Text == "RIGHT" then
		input = 0
		script.Parent.Text = "MIDDLE"
	elseif script.Parent.Text == "MIDDLE" then
		input = -1.75
		script.Parent.Text = "LEFT"
	elseif script.Parent.Text == "LEFT" then
		input = 1.75
		script.Parent.Text = "RIGHT"
	end
	
	ChangeData:FireServer(SettingDataHolder, input)
end

if SettingDataHolder.Value == 1.75 then
	input = "RIGHT"
	script.Parent.Text = input
elseif SettingDataHolder.Value == 0 then
	input = "MIDDLE"
	script.Parent.Text = input
elseif SettingDataHolder.Value == -1.75 then
	input = "LEFT"
	script.Parent.Text = input
end

script.Parent.MouseButton1Click:Connect(function()
	change()
end)