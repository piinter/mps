local RunService = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local Character = script.Parent
local Player = Players:FindFirstChild(Character.Name)


local ballfolder = game.Workspace.Balls

local function updateCollisionGroup()
	for i, ball in pairs (ballfolder:GetChildren()) do
		if ball.Owner.Value == Player then
			PhysicsService:SetPartCollisionGroup(ball, "Balls")
		else
			PhysicsService:SetPartCollisionGroup(ball, "Humans")
		end
	end
end

RunService.Heartbeat:Connect(updateCollisionGroup)