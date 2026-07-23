local PhysicsService = game:GetService("PhysicsService")

function setCollisionGroupRecursive(object)
	if object:IsA("BasePart") then
		object.CollisionGroup = "Balls"
	end
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end

task.wait(0.5)
setCollisionGroupRecursive(script.Parent)