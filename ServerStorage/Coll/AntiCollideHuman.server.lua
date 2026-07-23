local PhysicsService = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")
local Ball = game.Workspace.Balls:FindFirstChild("TPS")

function setCollisionGroupRecursive(object)
	if object:IsA("BasePart") then
		object.CollisionGroup = "Colls"
	end
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end

task.wait(0.5)
setCollisionGroupRecursive(script.Parent)