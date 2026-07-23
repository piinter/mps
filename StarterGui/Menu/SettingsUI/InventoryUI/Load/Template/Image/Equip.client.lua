repeat wait() until game:IsLoaded()

local RS = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local Data = player:WaitForChild("PlayerData")
local DataHolder = Data:WaitForChild("CurrentEquippedPinImageId")
local Remotes = RS:WaitForChild("Data")
local ChangeData = Remotes:WaitForChild("ChangeData")

function change()
	ChangeData:FireServer(DataHolder, script.Parent.Image)
end

script.Parent.MouseButton1Click:Connect(function()
	change()
end)