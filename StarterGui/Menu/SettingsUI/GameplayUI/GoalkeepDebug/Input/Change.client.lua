repeat wait() until game:IsLoaded()

local RS = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Data = player:WaitForChild("PlayerData")
local SettingDataHolder = Data:WaitForChild("Settings"):WaitForChild("GoalkeepDebug")
local Remotes = RS:WaitForChild("Data")
local ChangeData = Remotes:WaitForChild("ChangeData")

function change()
	local input = true
	
	
	if SettingDataHolder.Value == false then
		input = true
		script.Parent.Text = "TRUE"
		script.Parent.TextColor3 = Color3.new(0, 255 / 255, 0)
	else
		input = false
		script.Parent.Text = "FALSE"
		script.Parent.TextColor3 = Color3.new(255 / 255, 0, 0)
	end
	
	ChangeData:FireServer(SettingDataHolder, input)
end

if SettingDataHolder.Value == true then
	script.Parent.Text = "TRUE"
	script.Parent.TextColor3 = Color3.new(0, 255 / 255, 0)
else
	script.Parent.Text = "FALSE"
	script.Parent.TextColor3 = Color3.new(255 / 255, 0, 0)
end

script.Parent.MouseButton1Click:Connect(function()
	change()
end)