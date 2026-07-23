local PhysicsService = game:GetService("PhysicsService")
local EOS = game.Workspace.Balls:WaitForChild("TPS")

PhysicsService:RegisterCollisionGroup("Balls")
PhysicsService:RegisterCollisionGroup("Humans")
PhysicsService:RegisterCollisionGroup("Colls")
PhysicsService:RegisterCollisionGroup("Barrier")

PhysicsService:CollisionGroupSetCollidable("Humans", "Balls", false)
PhysicsService:CollisionGroupSetCollidable("Humans", "Humans", false)
PhysicsService:CollisionGroupSetCollidable("Humans", "Colls", false)
PhysicsService:CollisionGroupSetCollidable("Colls", "Balls", true)
PhysicsService:CollisionGroupSetCollidable("Humans", "Barrier", true)
PhysicsService:CollisionGroupSetCollidable("Barrier", "Balls", true)

function setCollisionGroupRecursive(object)
	if object:IsA("BasePart") then
		object.CollisionGroup = "Humans"
	end
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end

function onCharacterAdded(character)
	wait(0.2) 
	setCollisionGroupRecursive(character)  
end

function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)  
end

game.Players.PlayerAdded:Connect(onPlayerAdded)
