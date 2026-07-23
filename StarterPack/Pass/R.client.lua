local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
local PhysicsService = game:GetService("PhysicsService")
local torsos = Player.Character:FindFirstChild("Torso")
local header = Player.Character:FindFirstChild("Head")

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)


Mouse.KeyDown:connect(function(key)
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "r" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	PhysicsService:SetPartCollisionGroup(torsos, "Humans")
	PhysicsService:SetPartCollisionGroup(header, "Humans")
	Kick = true
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/6,0.3,0))
	wait(0.15)
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0,0))
	else
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/6,-0.3,0))
	wait(0.15)
	TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0,0))
	end
	wait(0.25)
	TM.ResetWelds()
	PhysicsService:SetPartCollisionGroup(torsos, "Colls")
	PhysicsService:SetPartCollisionGroup(header, "Colls")
	Kick = false
	wait(0.1)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * -60
	local angle = Vector3.new(6e+006,2e+003,6e+006)
	Kick = false
 
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * -60
	local angle = Vector3.new(6e+006,2e+003,6e+006)
	Kick = false
 
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
