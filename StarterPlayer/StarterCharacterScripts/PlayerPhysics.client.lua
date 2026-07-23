local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local original = character.HumanoidRootPart.AssemblyLinearVelocity

humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(original.X, math.clamp(original.Y, -200, 200), original.Z)

for i, Limbs in pairs(character:GetChildren()) do
	if Limbs:IsA("BasePart") and Limbs.Name ~= "Head" then
		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.5, 0.2, 0, 1, 100)
	end
end

 for i, Limbs in pairs(character:GetChildren()) do
 	if Limbs:IsA("BasePart") and Limbs.Name == "Right Leg" then
 		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0, 0, 0, 0)
 	end
 end

 for i, Limbs in pairs(character:GetChildren()) do
 	if Limbs:IsA("BasePart") and Limbs.Name == "Left Leg" then
 		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0, 0, 0, 0)
 	end
 end

 for i, Limbs in pairs(character:GetChildren()) do
 	if Limbs:IsA("BasePart") and Limbs.Name == "Right Arm" then
 		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0, 0, 0, 0)
 	end
 end

 for i, Limbs in pairs(character:GetChildren()) do
 	if Limbs:IsA("BasePart") and Limbs.Name == "Left Arm" then
 		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0, 0, 0, 0)
 	end
 end


--game:GetService("RunService").RenderStepped:Connect(function()
--	game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
--end)

--for i, Limbs in pairs(character:GetChildren()) do
--	if Limbs:IsA("BasePart") and Limbs.Name == "HumanoidRootPart" then
--		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 100)
--	end
--end

--for i, Limbs in pairs(character:GetChildren()) do
--	if Limbs:IsA("BasePart") and Limbs.Name == "Torso" then
--		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 100)
--	end
--end

--for i, Limbs in pairs(character:GetChildren()) do
--	if Limbs:IsA("BasePart") and Limbs.Name == "Head" then
--		Limbs.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
--	end
--end