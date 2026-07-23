repeat wait() until game:IsLoaded()

local RS = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Data = player:WaitForChild("PlayerData")
local SettingDataHolder = Data:WaitForChild("Settings"):WaitForChild("PowerPercentage")
local Remotes = RS:WaitForChild("Data")
local ChangeData = Remotes:WaitForChild("ChangeData")

function change()
	local input = true
	
	player.PlayerGui.Powerbar.Percent.Visible = not player.PlayerGui.Powerbar.Percent.Visible
	
	if player.PlayerGui.Powerbar.Percent.Visible == true then
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

player.PlayerGui.Powerbar.Percent.Visible = SettingDataHolder.Value

if player.PlayerGui.Powerbar.Percent.Visible == true then
	script.Parent.Text = "TRUE"
	script.Parent.TextColor3 = Color3.new(0, 255 / 255, 0)
else
	script.Parent.Text = "FALSE"
	script.Parent.TextColor3 = Color3.new(255 / 255, 0, 0)
end

script.Parent.MouseButton1Click:Connect(function()
	change()
end)