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
	if key ~= "z" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	PhysicsService:SetPartCollisionGroup(torsos, "Humans")
	PhysicsService:SetPartCollisionGroup(header, "Humans")
	Player.Character.Torso.RotVelocity = Vector3.new()
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	local BV = Instance.new("BodyVelocity", Player.Character.HumanoidRootPart)
	BV.Velocity = Vector3.new(0, -5, 0)
	BV.MaxForce = Vector3.new(0, 1500, 0)

	game.Debris:AddItem(BV, 1)
	TM.EditWeld("Head", CFrame.new(0,1.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/-3,0,0))
	Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame + Vector3.new(0,0.7,0)
	Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(-1.3,0,0)
	Player.Character.Humanoid.PlatformStand = true
	Kick = true
	wait(0.5)
	TM.ResetWelds()
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	Player.Character.Humanoid.PlatformStand = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	PhysicsService:SetPartCollisionGroup(torsos, "Colls")
	PhysicsService:SetPartCollisionGroup(header, "Colls")
	Kick = false
	wait(1)
	TM.SetUsing(false)
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 90
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 90
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
