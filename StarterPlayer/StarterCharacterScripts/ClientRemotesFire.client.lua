local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = script.Parent

local HRP = Character:WaitForChild("HumanoidRootPart")
local Torso = Character:WaitForChild("Torso")
local Head = Character:WaitForChild("Head")
local RA = Character:WaitForChild("Right Arm")
local LA = Character:WaitForChild("Left Arm")
local RL = Character:WaitForChild("Right Leg")
local LL = Character:WaitForChild("Left Leg")

-- this is client anticheat yaaaay


script.Parent.ChildRemoved:Connect(function(c)
	if c.Name == "BallPhysicsHandle" or c.Name == "Jerseys" or c.Name == "ClientPing" or c.Name == "Physics" or c.Name == "ClientRemotesFire" or c.Name == "BallCollision" or c.Name == "Collisions" or c.Name == "CollisionsLoop" then
		game.ReplicatedStorage.AntiCheat:FireServer("Tried to remove a Script.")
end
end)

--[[--script.Parent.ChildAdded:Connect(function(c)
	if c:IsA("Script") then
		game.ReplicatedStorage.AntiCheat:FireServer("Tried to Insert a Script.")
	end
end)--]]--

-- more will be added in future i cba to make anti player ui rn